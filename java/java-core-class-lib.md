# Java常用核心类库

## 字符串

### String类

- 创建字符串

```java
char[] a = {'s', 't', 'u', 'd', 'e', 'n', 't'};
String s = new String(a);
String s = new String("student");
String s = new String(a, 2, 4);
String s = new String("uden");
```

- 连接字符串

	- +

- 格式输出

	- <String>.formt("%");

- 获取字符串信息

	- 长度

		- <String>.length()

	- 查询字符串

		- 首次出现

			- <String>.indexOf(String str)

		- 末次出现

			- <String>.lastindexOf(String str)

		- 获取索引处字符串

			- <String>.charAt(int index)

	- 字符串操作

		- 获取子字符串

			- <String>.substring(int beginIndex)
			- <String>.substring(int beginIndex, int endIndex)

		- 去除空格

			- <String>.trim()

		- 替换字符串

			- <String>.replace(CharSequence target, CharSequence replacement)

		- 判断是否以指定开头与结尾

			- <String>.startsWith(String prefix)
			- <String>.endsWith(String prefix)

		- 判断字符串是否相等

			- <String>.equals(String otherstr)
			- <String>.equalsIgnoreCase(String otherstr)

				- 忽略大小写

		- 字典顺序比对字符串

			- <String>.compareTo(String otherstr)

		- 大小写转化

			- <String>.toLowerCase()
			- <String>.toUpperCase()

		- 分割字符串

			- <String>.split(String sign)
			- <String>.split(String sign, int limit)

- 字符串生成器

	- StringBuilder类

		- appand(content)
		- insert(int offset, arg)
		- delete(int start, int end)

## 包装类

### Integer类

### Double类

### Boolean类

### Character类

### Number类

## 数字处理

### 数字格式化

### Math类

### Random类

### BigInteger类

### BigDecimal类

## 系统类

### System类

### Scanner类

## 日期时间类

### Date类

### Calendar类

### 日期时间格式化类

## 集合类

### Collection接口

### List接口

### Set接口

### Map接口

### Collections类

### 遍历类

## 枚举类

