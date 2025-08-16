# 重排序问题

编译器 / cpu 为了优化执行性能，会对代码的执行顺序进行重排序。这通常是没有问题的，但是在 `并发` 的场景中，往往会产生灾难性的难以察觉的bug.

# 重排序解决方案

简单来说就是阻止重排序的发生，即：设置内存屏障。


| 工具 / 关键字               | 作用                     |
| ---------------------- | ---------------------- |
| `volatile`             | 防止编译器优化（⚠️不能防止 CPU 重排） |
| `std::atomic`          | 提供原子操作 + 可控内存序（强烈推荐）   |
| `memory_order_seq_cst` | 顺序一致性（最严格的防重排保证）       |
| `memory barriers`      | 硬件层指令，如 `mfence`，手动加屏障 |

## cpp案例演示

### 原子操作

| 内存序语义             | 描述                       | 防重排能力    |
| ---------------------- | ------------------------ | -------- |
| `memory_order_relaxed` | 仅保证原子性，不做任何顺序限制          | ❌ 不防重排   |
| `memory_order_acquire` | 后续读取不能被提前到这个加载（load）之前   | ✅ 读取防乱序  |
| `memory_order_release` | 之前的写入不能被拖延到这个写入（store）之后 | ✅ 写入防乱序  |
| `memory_order_acq_rel` | 组合了 acquire 和 release    | ✅ 读写都防乱序 |
| `memory_order_seq_cst` | 顺序一致性，**最强语义**：全局总有序     | ✅✅✅ 强防重排 |

其中只有 `memory_order_seq_cst` 语义，包含严格的全局单一序(SC order)。

#### `memory_order_relaxed`

仅仅保证了 `atomic` 变量的最低原子性，如：多线程变量内存访问的加锁问题。

#### `memory_order_acquire` & `memory_order_release`

单独保证原子量前后的普通变量的读写操作的防乱序。

- `memory_order_acquire`: load 之后的读取不得提前至该原子之前
- `memory_order_release`: store 之前的写入不得拖延至该原子之后

```cpp
std::atomic<bool> flag(false);
int data = 0;

void writer() {
    data = 42;
    flag.store(true, std::memory_order_release);
}

void reader() {
    if (flag.load(std::memory_order_acquire)) {
        std::cout << data << std::endl;  // 可能 flag.load 为 false
                                         // 但一旦读取到, data 必然是 42
    }
}
```

| 特性                | release / acquire                      | seq\_cst |
| ----------------- | -------------------------------------- | -------- |
| 普通变量可见性           | ✅ 只要 load 读到 store 写入的值，就能看到 store 前的写 | ✅ 同样保证   |
| 防止本线程重排序          | ✅                                      | ✅        |
| 全局单一顺序（所有线程一致的轨道） | ❌                                      | ✅        |
| 性能                | 较高（比 seq\_cst 更轻）                      | 较低       |

#### `memory_order_acq_rel`

`memory_order_acq_rel` 语义的使用场景是既需要读又需要写，单独的 load/store 使用该语义是无意义的。

```cpp
std::atomic<int> counter{0};

void task() {
    // 同时具备读取旧值（acquire）和写入新值（release）的语义
    int old = counter.fetch_add(1, std::memory_order_acq_rel);

    // old 是之前的值，acquire 保证能看到它对应的内存状态
    // release 保证当前线程之前的写对之后读到这个值的线程可见
}
```

#### `memory_order_seq_cst`

保证的是，当前原子变量，在全局宏观中，所有的 load 操作一定落后于 store 操作。但无法保证使用 seq_cst 语义的原子变量与之前后的普通变量的执行顺序问题。

> [!NOTE]
> 同时，值得注意的是， cpp 中 atomic 变量的 store/load 操作，默认为 `memory_order_seq_cst`

```cpp
std::atomic<bool> flag{false};
int data = 0;

void writer() {
    data = 42;  // 非 atomic 写
    flag.store(true, std::memory_order_seq_cst);  // atomic 写
}

void reader() {
    if (flag.load(std::memory_order_seq_cst)) {   // atomic 读
        std::cout << data << std::endl;  // 非 atomic 读
    }
}
```

标准能够保证：
- [x] `flag.store` 与 `flag.load` 的顺序，在所有线程眼里完全一致。
- [x] `flag == true` 时， `data == 42`

### 内存屏障

```cpp
// core 1
x = 1;
memory_barrier();  // 确保上面的写入完成
flag = 1;

// core 2
if (flag == 1) {
    memory_barrier();  // 确保读取 flag 后再读取 x
    assert(x == 1);    // 成立！
}
```
