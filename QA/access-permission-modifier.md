# CPP中的访问权限修饰符

在 C++ 中，**三个权限访问修饰符（Access Specifiers）**用于控制类成员（变量、函数）的访问权限，分别是：  

| 修饰符      | 类内访问 | 类外访问 | 继承时对子类的影响                     |
|-----------|--------|--------|----------------------------------|
| **public**  | ✅ 可以  | ✅ 可以  | 子类继承时，public成员保持 public       |
| **protected** | ✅ 可以  | ❌ 不可以 | 子类继承时，protected成员保持 protected |
| **private**  | ✅ 可以  | ❌ 不可以 | 子类继承时，private成员对子类不可见     |

---

## 1. **public（公有）**
- **作用**：任何地方都可以访问，类外、子类都能访问。
- **用途**：一般用于对外接口（成员函数）或需要公开的数据。

```cpp
class MyClass {
public:
    int x; // 公有成员
    void show() { cout << x << endl; }
};
```

✅ 访问示例：
```cpp
MyClass obj;
obj.x = 10;  // 合法
obj.show(); // 合法
```

---

## 2. **protected（受保护）**
- **作用**：**类内**和**子类**可以访问，**类外**不可访问。
- **用途**：供类和子类内部使用，外部不可见，但允许子类继承和使用。

```cpp
class MyClass {
protected:
    int y;
};

class Derived : public MyClass {
public:
    void setY(int val) { y = val; } // 子类可以访问
};
```

❌ 类外无法访问：
```cpp
MyClass obj;
// obj.y = 20; // 错误，类外不可访问
```

---

## 3. **private（私有）**
- **作用**：只有**类内**可以访问，**子类**和**类外**都不能访问。
- **用途**：封装数据，保护类的内部实现细节。

```cpp
class MyClass {
private:
    int z;
public:
    void setZ(int val) { z = val; } // 提供公有接口
    int getZ() { return z; }
};
```

✅ 访问示例：
```cpp
MyClass obj;
obj.setZ(30); // 通过公有接口访问
cout << obj.getZ(); // 30
```

❌ 直接访问：
```cpp
// obj.z = 30; // 错误，z 是私有成员
```

---

## 关于继承访问权限修饰符

| 基类成员权限 | 公有继承(public) | 保护继承(protected) | 私有继承(private) |
| ------------ | ---------------- | ------------------- | ----------------- |
| public成员 | 作为public成员继承 | 作为protected成员继承 | 作为private成员继承 |
| protected成员 | 作为protected成员继承 | 作为protected成员继承 | 作为private成员继承 |
| private成员 | 不继承(不可访问) | 不继承(不可访问) | 不继承(不可访问) | 不继承(不可访问) |

---

## 总结：
| 修饰符       | 类内访问 | 子类访问 | 类外访问 |
|------------|--------|--------|--------|
| **public**   | ✅      | ✅      | ✅      |
| **protected**| ✅      | ✅      | ❌      |
| **private**  | ✅      | ❌      | ❌      |

# Java中的访问权限修饰符

在 **Java** 中，也有**三个主要的访问权限修饰符**，用于控制类、属性和方法的访问范围，分别是：  

| 修饰符        | 同类（类内部） | 同包（包内其他类） | 子类（不同包继承类） | 其他包 |
|------------|-------------|-----------------|----------------|------|
| **public**   | ✅          | ✅               | ✅             | ✅   |
| **protected**| ✅          | ✅               | ✅             | ❌   |
| **default** (无修饰符) | ✅          | ✅               | ❌             | ❌   |
| **private**  | ✅          | ❌               | ❌             | ❌   |

⚠️ **注意**：Java 中并没有 `default` 关键字作为访问修饰符，通常叫做**包访问权限**或**默认访问权限**，即 **不写任何修饰符** 时的默认行为。

---

## 1. **public（公有）**
- **作用**：所有地方都能访问（类、包、子类、其他包）。
- **应用**：一般用于对外暴露接口、常用工具类方法等。

```java
public class MyClass {
    public int x;
    public void show() { System.out.println(x); }
}
```

✅ 使用：
```java
MyClass obj = new MyClass();
obj.x = 10; // 任何地方都可以访问
obj.show();
```

---

## 2. **protected（受保护）**
- **作用**：同类、同包、**不同包中的子类**可以访问。
- **应用**：用于继承相关，保护类的成员但允许子类访问。

```java
public class MyClass {
    protected int y;
}

class SubClass extends MyClass {
    void display() {
        System.out.println(y); // 可以访问
    }
}
```

❌ 跨包非子类不可访问：
```java
// 其他包非子类无法访问 y
```

---

## 3. **default（包访问权限）**
- **作用**：同类、同包可以访问，不允许不同包或子类访问。
- **应用**：适合包内部工具、辅助类的成员。

```java
class MyClass { // 无修饰符，包访问权限
    int z; // 无修饰符，包访问权限
    void print() { System.out.println(z); }
}
```

✅ 同包访问，❌ 不同包不可访问。

---

## 4. **private（私有）**
- **作用**：**只有同类内部**可以访问。
- **应用**：用于隐藏内部实现细节，保护数据。

```java
public class MyClass {
    private int a;
    private void secret() { System.out.println(a); }
}
```

✅ 类内部方法可以访问，❌ 其他类不可访问：
```java
MyClass obj = new MyClass();
// obj.a = 10; // 错误，a 是私有成员
```

---

## ✅ 总结：
| 修饰符        | 类内 | 同包 | 子类（跨包） | 其他包 |
|------------|------|------|-----------|------|
| **public**   | ✅    | ✅    | ✅         | ✅    |
| **protected**| ✅    | ✅    | ✅         | ❌    |
| **default**  | ✅    | ✅    | ❌         | ❌    |
| **private**  | ✅    | ❌    | ❌         | ❌    |

---

### 🔑 总结要点：
- **public**：任何地方都能访问。
- **protected**：同包 + 跨包子类。
- **default**（无修饰符）：同包。
- **private**：类内。

# 对比及共同点

## 共同点

`public`永远是最宽松的, 其次是`protected`, 最后是`private`.
它们的严苛关系递进一次显现在 类内 -> 类外 -> 继承子类

## CPP v.s. Java

- CPP:

    | 修饰符      | 类内访问 | 类外访问 | 继承时对子类的影响                     |
    |-----------|--------|--------|----------------------------------|
    | **public**  | ✅ 可以  | ✅ 可以  | 子类继承时，public成员保持 public       |
    | **protected** | ✅ 可以  | ❌ 不可以 | 子类继承时，protected成员保持 protected |
    | **private**  | ✅ 可以  | ❌ 不可以 | 子类继承时，private成员对子类不可见     |

- Java:

    | 修饰符        | 同类（类内部） | 同包（包内其他类） | 子类（不同包继承类） | 其他包 |
    |------------|-------------|-----------------|----------------|------|
    | **public**   | ✅          | ✅               | ✅             | ✅   |
    | **protected**| ✅          | ✅               | ✅             | ❌   |
    | **default** (无修饰符) | ✅          | ✅               | ❌             | ❌   |
    | **private**  | ✅          | ❌               | ❌             | ❌   |

