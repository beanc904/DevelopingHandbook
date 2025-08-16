# Rust常见宏

一般来说，Rust宏可以分为三类：
1. 声明宏（Declarative Macros）：使用`macro_rules!`定义的宏。
2. 过程宏（Procedural Macros）：使用函数来生成代码的宏，分为三种类型：自定义派生宏（Custom Derive Macros）、属性宏（Attribute Macros）和函数宏（Function-like Macros）。
3. 内置宏（Built-in Macros）：Rust语言自带的一些宏，如`println!`、`vec!`等。

着重讲述两类宏：属性宏(attribute macros)和过程宏(procedural macros)

## 属性宏(attribute macros)

属性宏是一种特殊的过程宏，允许你为结构体、枚举或函数添加自定义属性，从而改变它们的行为。属性宏通常用于代码生成、自动实现某些特性或进行编译时检查。

其中最常见的属性宏是`derive`宏，它允许你为类型自动生成实现某些常用特性的代码。以下是一些常见的`derive`宏及其功能：

| 宏                       | 功能                                      | 举例                                      |
| ----------------------- | --------------------------------------- | --------------------------------------- |
| `#[derive(Debug)]`      | 让类型可以用 `{:?}` 格式化输出（调试打印）               | `println!("{:?}", my_struct);`          |
| `#[derive(Clone)]`      | 生成 `clone()` 方法，做深拷贝                    | `let b = a.clone();`                    |
| `#[derive(Copy)]`       | 让类型能按位复制（必须也实现 `Clone`，且成员都是 `Copy` 类型） | `let b = a;` 之后 `a` 仍可用                 |
| `#[derive(PartialEq)]`  | 实现 `==` / `!=` 比较                       | `a == b`                                |
| `#[derive(Eq)]`         | 完全等价比较（必须基于 `PartialEq`）                | 用于哈希集合等                                 |
| `#[derive(PartialOrd)]` | 实现 `<, >, <=, >=` 比较                    | 排序时用                                    |
| `#[derive(Ord)]`        | 全序比较（基于 `PartialOrd`）                   | 在 `BTreeMap` 等有序集合中使用                   |
| `#[derive(Hash)]`       | 实现 `Hash`，可用作 `HashMap` 的 key           | `map.insert(my_struct, value);`         |
| `#[derive(Default)]`    | 提供默认值构造方法 `Default::default()`          | `let x: MyStruct = Default::default();` |

其他常用属性宏：

| 宏                                 | 作用                             | 场景                                               |
| --------------------------------- | ------------------------------ | ------------------------------------------------ |
| `#[allow(...)]`                   | 忽略特定编译器警告                      | `#[allow(dead_code)] fn foo() {}`                |
| `#[warn(...)]`                    | 把某类问题设为警告                      | `#[warn(unused_variables)]`                      |
| `#[deny(...)]`                    | 把某类问题设为编译错误                    | `#[deny(missing_docs)]`                          |
| `#[cfg(...)]`                     | 条件编译                           | `#[cfg(target_os = "linux")] fn only_linux() {}` |
| `#[cfg_attr(...)]`                | 条件地添加属性                        | `#[cfg_attr(debug_assertions, derive(Debug))]`   |
| `#[inline]` / `#[inline(always)]` | 提示编译器内联函数                      | 高性能场景                                            |
| `#[non_exhaustive]`               | 防止外部 exhaustively match 枚举/结构体 | 库 API 兼容性                                        |

测试相关属性宏：

| 宏                 | 功能                |
| ----------------- | ----------------- |
| `#[test]`         | 标记一个单元测试函数        |
| `#[should_panic]` | 测试函数必须 panic 才算通过 |
| `#[ignore]`       | 跳过某个测试            |

## 过程宏(procedural macros)

过程宏是一种更强大的宏，允许你编写类函数或者元属性来生成代码。

| 宏                                               | 来源             | 功能                              |
| ----------------------------------------------- | -------------- | ------------------------------- |
| `#[tokio::main]`                                | `tokio`        | 把 async main 变成普通 main 并自动启动运行时 |
| `#[wasm_bindgen]`                               | `wasm-bindgen` | WebAssembly 与 JS 交互             |
| `#[serde::Serialize]` / `#[serde::Deserialize]` | `serde`        | 序列化与反序列化                        |
| `#[actix_web::get("/path")]`                    | `actix-web`    | Web 路由绑定                        |
| `#[derive(Parser)]`                             | `clap`         | 命令行参数解析                         |
