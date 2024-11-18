# 正则表达式

正则表达式（Regular Expression，简称 regex 或 regexp）是一种强大的**文本匹配**工具，用于描述特定的字符串模式。它广泛应用于文本处理、搜索、替换、验证和数据提取。

---

### 简单预览

```regex
t[ei]([ex]a)*t
```

则匹配对象可有以下

```regex
texat
tixat
......
```

---

### **正则表达式的组成**

正则表达式由**普通字符**和**元字符**（特殊符号）组成，用于构建匹配规则。

#### 1. **普通字符**

普通字符会直接匹配文本中的相同字符。

- 示例：`cat` 匹配字符串 `cat`。

#### 2. **元字符**

元字符是正则表达式的核心，用于定义模式。

| 元字符 | 含义 | 示例 |
|--------|------|------|
| `.`    | 匹配任意单个字符（除换行符外） | `c.t` 匹配 `cat`, `cot` |
| `^`    | 匹配字符串的开头 | `^hello` 匹配 `hello world` 中的 `hello` |
| `$`    | 匹配字符串的结尾 | `world$` 匹配 `hello world` 中的 `world` |
| `*`    | 匹配前一个字符 0 次或多次 | `a*` 匹配 `aaa` 或空 |
| `+`    | 匹配前一个字符 1 次或多次 | `a+` 匹配 `aaa`，但不匹配空 |
| `?`    | 匹配前一个字符 0 次或 1 次 | `colou?r` 匹配 `color` 和 `colour` |
| `{}`   | 匹配指定次数 | `a{2,4}` 匹配 2 到 4 个 `a` |
| `[]`   | 匹配字符集合中的任意一个 | `[abc]` 匹配 `a`, `b`, 或 `c` |
| `\|`   | 或运算符 | `cat\|dog` 匹配 `cat` 或 `dog` |
| `()`   | 定义分组 | `(ab)+` 匹配 `ab`, `abab` |
| `\`    | 转义符 | `\.` 匹配 `.` 而不是任意字符 |

---

### **常用的预定义字符类**

字符类简化了常见字符的匹配。

| 字符类   | 含义                           | 示例                     |
|----------|--------------------------------|--------------------------|
| `\d`     | 匹配任意数字（0-9）            | `\d+` 匹配 `123`         |
| `\w`     | 匹配任意字母、数字或下划线      | `\w+` 匹配 `hello_123`   |
| `\s`     | 匹配空白字符（空格、制表符等）  | `\s+` 匹配多个空格       |
| `\D`     | 匹配非数字字符                 | `\D+` 匹配 `abc`         |
| `\W`     | 匹配非字母、数字或下划线       | `\W+` 匹配 `!@#`         |
| `\S`     | 匹配非空白字符                 | `\S+` 匹配 `hello`       |

---

### **匹配模式修饰符**

正则表达式支持修饰符来控制匹配行为：

- `i`：忽略大小写。
- `m`：多行模式（`^` 和 `$` 匹配每行的开头和结尾）。
- `s`：让 `.` 匹配换行符。

---

### **正则表达式的常见应用**

#### 1. **文本搜索**

匹配包含特定模式的字符串。

```java
String text = "hello world";
String pattern = "world";
boolean matches = text.matches(".*" + pattern + ".*");
System.out.println(matches); // 输出：true
```

#### 2. **验证**

检查输入是否符合规则（如邮箱、手机号）。

```java
String email = "test@example.com";
String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
System.out.println(email.matches(emailPattern)); // 输出：true
```

#### 3. **替换**

替换匹配到的文本。

```java
String text = "hello 123 world";
String result = text.replaceAll("\\d+", "456");
System.out.println(result); // 输出：hello 456 world
```

#### 4. **分割**

按模式分割字符串。

```java
String text = "apple,banana,orange";
String[] fruits = text.split(",");
System.out.println(Arrays.toString(fruits)); // 输出：[apple, banana, orange]
```
