# 四种常见`cpp`类型转换

四种类型转换:

- static_cast<>()
- dynamic_cast<>()
- const_cast<>()
- reinterpret_cast<>()

## `static_cast`

用于编译时类型转换，类型关系明确且合法时使用。

常用于: 
- 基本类型的转换
- 明确继承关系的多态转换

注意: `static_cast`属于编译时检查, 并没有运行时检查. 开销不如`dynamic_cast`.

```cpp
// 基本数据类型的转换
int i = 10;
double d = static_cast<double>(i);

// 多态继承的转换
class Base {};
class Derived : public Base {};

Base* base = new Derived();
Derived* derived = static_cast<Derived*>(base);
```

## `dynamic_cast`

用于安全的多态类型转换，通常用于指针或引用之间的转换，并且要求有虚函数。

常用于:
- 不定继承关系的多态转换

注意: `dynamic_cast`是运行时检查, 开销较大, 但同时也比较安全. 转换失败则会注入`nullptr`(指针转换), 或抛出`std::bad_cast`异常(引用转换).

```cpp
class Base {
    virtual void func() {}
};
class Derived : public Base {};

Base* base = new Derived();
Derived* derived = dynamic_cast<Derived*>(base);
if (derived) {
    // 转换成功
} else {
    // 转换失败
}
```

## `const_cast`

用于添加或去除常量属性。

常用于:
- 常量与非常量之间的转换
- 函数签名的解常量

注意: 如果该原始常量存储于只读内存区, 强制`const_cast`并修改会产生`UB`.

```cpp
// 该操作可能会有UB风险
const int i = 10;
int* p = const_cast<int*>(&i);
*p = 20;                        // 可能UB

// 去除const的正确用处
void foo(const int* p) {
    int* modifiable_ptr = const_cast<int*>(p);  // 去掉 const
    *modifiable_ptr = 10;  // 只要确保这个对象实际是可以修改的
}

// 常用正确方法
void print(const int* p) {
    // 这里我们确保传入的参数不能被修改
}

int i = 5;
print(const_cast<const int*>(&i));  // 通过 const_cast 给非 const 对象添加 const
```

## `reinterpret_cast`

用于进行低级别的类型转换，通常用于将指针转换为不同类型的指针，风险较大。

常用于:
- 不同基类指针类型的转换

注意: 风险较大!

```cpp
// 整数转指针
int i = 10;
void* ptr = reinterpret_cast<void*>(&i);

// 指针互转
char* cptr = reinterpret_cast<char*>(intptr);
```
