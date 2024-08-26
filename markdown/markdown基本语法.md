Markdown 是一种轻量级标记语言，旨在以易读易写的纯文本格式编写文档，并能转换成结构化的HTML等格式。它广泛应用于写作、博客、论坛、GitHub 等平台。以下是 Markdown 的详细语法规则介绍：

## 1. 标题 (Headings)

Markdown 使用 `#` 符号来表示标题，共有六级标题，对应 HTML 的 `<h1>` 到 `<h6>`。

```markdown
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题
```

效果：

# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题

## 2. 段落与换行 (Paragraphs & Line Breaks)

段落由一个或多个空行分隔。要在段落中插入换行，可以在行尾添加两个或多个空格，然后回车。

```markdown
这是第一行。  
这是第二行。
```

效果：

这是第一行。  
这是第二行。

## 3. 强调 (Emphasis)

### 斜体 (Italic)

使用单个星号 `*` 或下划线 `_` 包围文本。

```markdown
*斜体文本*
_斜体文本_
```

效果：

*斜体文本*  
_斜体文本_

### 加粗 (Bold)

使用双星号 `**` 或双下划线 `__` 包围文本。

```markdown
**加粗文本**
__加粗文本__
```

效果：

**加粗文本**  
__加粗文本__

### 删除线 (Strikethrough)

使用双波浪线 `~~` 包围文本。

```markdown
~~删除线文本~~
```

效果：

~~删除线文本~~

## 4. 列表 (Lists)

### 无序列表 (Unordered Lists)

使用星号 `*`、加号 `+` 或减号 `-` 作为列表标记。

```markdown
- 项目一
- 项目二
  - 子项目二点一
  - 子项目二点二
* 项目三
+ 项目四
```

效果：

- 项目一
- 项目二
  - 子项目二点一
  - 子项目二点二
* 项目三
+ 项目四

### 有序列表 (Ordered Lists)

使用数字加点 `1.`、`2.` 等作为列表标记。

```markdown
1. 第一项
2. 第二项
   1. 子项二点一
   2. 子项二点二
3. 第三项
```

效果：

1. 第一项
2. 第二项
   1. 子项二点一
   2. 子项二点二
3. 第三项

## 5. 链接 (Links)

### 行内链接 (Inline Links)

使用方括号 `[]` 包围链接文本，紧接着使用圆括号 `()` 包围 URL。

```markdown
[OpenAI](https://www.openai.com)
```

效果：

[OpenAI](https://www.openai.com)

### 引用式链接 (Reference Links)

定义链接引用，然后在文本中使用引用名称。

```markdown
这是一个 [OpenAI][1] 的链接。

[1]: https://www.openai.com
```

效果：

这是一个 [OpenAI][1] 的链接。

[1]: https://www.openai.com

### 自动链接 (Automatic Links)

使用尖括号 `<>` 包围 URL 或邮箱地址。

```markdown
<https://www.openai.com>
<user@example.com>
```

效果：

<https://www.openai.com>  
<user@example.com>

## 6. 图片 (Images)

图片语法类似于链接，但前面加感叹号 `!`。

### 行内图片

```markdown
![替代文本](https://www.example.com/image.jpg)
```

效果：

![替代文本](https://www.example.com/image.jpg)

### 引用式图片

```markdown
![替代文本][image1]

[image1]: https://www.example.com/image.jpg
```

效果：

![替代文本][image1]

[image1]: https://www.example.com/image.jpg

## 7. 代码 (Code)

### 行内代码 (Inline Code)

使用反引号 `` ` `` 包围代码片段。

```markdown
这是一个 `inline code` 示例。
```

效果：

这是一个 `inline code` 示例。

### 代码块 (Code Blocks)

使用三个反引号 ```` ``` ```` 或四个空格缩进表示代码块。可以指定语言以启用语法高亮。

```markdown
```python
def hello_world():
    print("Hello, World!")
```
```

效果：

```python
def hello_world():
    print("Hello, World!")
```

### 缩进代码块

使用至少四个空格或一个制表符缩进。

```markdown
    def hello_world():
        print("Hello, World!")
```

效果：

    def hello_world():
        print("Hello, World!")

## 8. 引用 (Blockquotes)

使用 `>` 符号表示引用，可以嵌套多个 `>` 表示多层引用。

```markdown
> 这是一个引用。
> 
> 这是同一引用的第二段。

>> 这是嵌套的引用。
```

效果：

> 这是一个引用。
> 
> 这是同一引用的第二段。

>> 这是嵌套的引用。

## 9. 分隔线 (Horizontal Rules)

使用三个或以上的星号 `***`、减号 `---` 或下划线 `___`，独占一行。

```markdown
---
```

效果：

---

## 10. 表格 (Tables)

使用管道符 `|` 和短横线 `-` 来创建表格，可以指定对齐方式。

```markdown
| 左对齐 | 居中对齐 | 右对齐 |
| :----- | :------: | -----: |
| 内容1  | 内容2    | 内容3  |
| 内容4  | 内容5    | 内容6  |
```

效果：

| 左对齐 | 居中对齐 | 右对齐 |
| :----- | :------: | -----: |
| 内容1  | 内容2    | 内容3  |
| 内容4  | 内容5    | 内容6  |

## 11. 内联HTML (Inline HTML)

Markdown 支持在文档中嵌入HTML代码，这在标准Markdown语法无法实现某些格式时非常有用。

```markdown
<p style="color: red;">这是红色的文本。</p>
```

效果：

<p style="color: red;">这是红色的文本。</p>

## 12. 转义字符 (Escaping Characters)

要显示 Markdown 语法中的特殊字符，可以使用反斜杠 `\` 进行转义。

```markdown
\*这是星号\*
```

效果：

\*这是星号\*

显示为：*这是星号*

## 13. 插入符号 (Special Characters)

一些符号如 `&`, `<`, `>` 等可以直接使用或使用 HTML 实体。

```markdown
5 > 3
5 &lt; 10
```

效果：

5 > 3  
5 < 10

## 14. 注脚 (Footnotes) [扩展语法]

某些 Markdown 解析器支持注脚。

```markdown
这是一个带注脚的文本.[^1]

[^1]: 这是注脚内容。
```

效果：

这是一个带注脚的文本.[^1]

[^1]: 这是注脚内容。

## 15. 任务列表 (Task Lists) [扩展语法]

支持创建任务列表，常用于 GitHub 等平台。

```markdown
- [x] 完成任务一
- [ ] 完成任务二
- [ ] 完成任务三
```

效果：

- [x] 完成任务一
- [ ] 完成任务二
- [ ] 完成任务三

## 16. 内联数学公式 (Inline Math) [扩展语法]

一些解析器支持使用美元符号包围的数学公式。

```markdown
这是一个行内公式：$E = mc^2$。
```

效果：

这是一个行内公式：$E = mc^2$。

## 17. LaTeX 数学块 (Math Blocks) [扩展语法]

使用双美元符号包围的块级数学公式。

```markdown
$$
\int_{a}^{b} f(x) dx
$$
```

效果：

$$
\int_{a}^{b} f(x) dx
$$

## 18. 自动编号参考 (Auto-numbered References) [扩展语法]

某些扩展允许自动编号参考文献、图表等。

## 常见的 Markdown 扩展

不同平台或工具可能对标准 Markdown 进行扩展，支持更多功能，如表情符号、任务列表、脚注、内嵌视频等。以下是一些常见的扩展：

- **GitHub Flavored Markdown (GFM)**：支持任务列表、表格、自动链接、删除线等。
- **Markdown Extra**：支持表格、脚注、内嵌HTML等。
- **CommonMark**：标准化的 Markdown 规范，旨在解决不同实现之间的差异。

## 工具与编辑器

许多编辑器和工具支持 Markdown 语法高亮和实时预览，如：

- **Typora**：所见即所得的 Markdown 编辑器。
- **Visual Studio Code**：通过插件支持 Markdown 预览和增强功能。
- **MarkdownPad**（Windows）
- **MacDown**（macOS）

## 小结

Markdown 通过简单的语法规则，使得编写格式化文本变得简便。掌握基本语法后，可以高效地创建清晰、结构化的文档。根据不同需求和平台，您还可以探索和使用各种 Markdown 扩展，进一步提升文档的表现力和功能。