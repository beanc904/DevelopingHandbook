# char in cpp

| Type | Size/byte | Code | Profix | Example | Introduce Standard |
| ---- | --------- | ---- | ------ | ------- | ------------------ |
| char | 1 | ASCII | none | `char c = 'A';` | C++98 |
| wchar_t| sys def | Unicode/GBK | `L` | `wchar_t wc = L'中';` | C++98 |
| char8_t | 1 | UTF-8 | `u8` | `char8_t u8c = u8'a';` | C++20 |
| char16_t | 2 | UTF-16 | `u` | `char16_t u16c = u'😊';` | C++11 |
| char32_t | 4 | UTF-32 | `U` | `char32_t u32c = U'𐍈';` | C++11 |

| Type | Size/byte | property |
| ---- | --------- | -------- |
| UTF-8 | 1-3 | 变长 |
| UTF-16 | 2/4 | 变长 |
| UTF-32 | 4 | 定长 |

---

需要注意是，`char`和`char8_t`解决的仅仅是歧义的问题，它们的底层存储依旧只是 1 byte / 8 bit.

而由于 `UTF-16` 是变长编码，故某些4字节字符会被解析为2个 `char16_t` 。

同时
```cpp
std::string.size()
std::string.length()
/* 两者完全相同，只不过前者为符合 stl 做出的重命名；后者则是沿用 C 风格。 */
/* 此外，该两者在进行运行时，做出的操作仅仅是返回 string 容器中存储基本单元 char char8_t 等的个数 */
```

#  common using

- `char`: 处理 ASCII 或传统文本（如文本 I/O）
- `char8_t`: 明确需要 UTF-8 编码时（如网络传输）
- `char16_t/char32_t`: 处理 Unicode 字符（如国际化文本处理）
- `wchar_t`: 遗留代码或平台特定需求（如 Windows API）

# common code

