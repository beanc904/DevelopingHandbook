# `Makefile`使用手簿

## `Makefile`基础

### 规则

规则是`Makefile`的主体，主要表现形式为如下:

```Makefile
# 目标文件: 依赖文件1 依赖文件2
m.out: a.o b.o
    g++ a.o b.o m.out
```

其含义为需要`m.out`文件时，自动搜索`a.o`和`b.o`文件，若存在则立即执行以下命令，不存在则向下搜索，并获取相关依赖文件。

### 伪目标

伪目标是`make`命令后的参数，使用相关参数后，则立刻执行`Makefile`中相关伪目标参数的命令。

伪目标关键词:
    - `clean`
    - `install`
    - 等等

伪目标标识符: `.PHONY`, 以下为其用法:

```Makefile
.PHONY clean
clean:
    rm -f m.o
    rm -f x.o
```

此时的`clean`不被视为文件，而是一个伪目标`(Phony Target)`，其中，`.PHONY`可视情况忽略不写。

---

**伪目标的多条命令执行规则**:

不同行的多条命令，是被创建在不同的`shell`中执行的，即：在仅换行的情况下，`cd`命令并不会更改工作目录，因为下一条命令是在一个新`shell`中运行。

其中有关键词: `;`, `\`, `&&`
- `;`: 一行为一个独立的`shell`环境，不同命令可以以`;`分开
- `\`: 可使用`\`将单行多命令分出多行显示
- `&&`: 在单行多命令中，前一条命令失败后，`&&`后的命令不会执行

```Makefile
# 下面进行演示
# 多行命令
cd_ok:
    pwd
    cd ..
    pwd

# 单行多命令
cd_ok:
    pwd; cd ..; pwd;

cd_ok:
    pwd && cd.. && pwd

# 单行多命令分行
cd_ok:
    pwd; \
    cd ..; \
    pwd
```

### 执行控制

- 打印控制：
    默认情况下，`make`会打印每一条命令，通过关键字符`@`可以阻止该条命令的打印。

- 错误控制：
    默认情况下，`make`在检测到上条命令的返回值非零时，会直接中断执行；通过关键字符`-`可以忽略返回错误，继续执行。

```Makefile
# 下面进行演示
no_output:
    @echo 'do not display'
    echo 'will display'

has_error:
    -rm not_exist_file.o
    rm not_exist_file.o
```

## 变量使用

变量的定义`变量名 = 值`或者`变量名 := 值`，通常变量名全大写。引用变量用`$(变量名)`。

变量通常由三种类型：普通文件名、文件名列表和自动文件列表。

```Makefile
# 下面进行演示
# 普通文件名
TARGET = main.out

# 文件名列表
OBJS = hello.o main.o

# 自动文件列表
# $(wildcard *.c)列出当前目录下的所有.c文件：hello.c main.c
# 再使用函数patsubst进行模式替换，得到：hello.o main.o
OBJS = $(patsubst %.c, %.o, $(wildcard *.c))
```

### 特殊变量

- 内置变量

    与*隐式规则*类似，即不用定义，即可使用该变量（规则）。内置变量，其中包含

    ```Makefile
    # c编译器
    CC = riscv64-linux-gnu-gcc
    ```

- 自动变量

    自动变量(Automatic Variable)，在一个规则中，自动指向某个值。

    有如下自动变量：

    ```Makefile
    # 对于该规则
    world.out: hello.o main.o
    	@echo '$$@ = $@' # 变量 $@ 表示target
        @echo '$$< = $<' # 变量 $< 表示第一个依赖项
        @echo '$$^ = $^' # 变量 $^ 表示所有依赖项
        cc -o $@ $^
    ```

    即：

    - `$@`:表示目标文件 
    - `$<`:表示第一个依赖项
    - `$^`:表示所有依赖项
    - `$*`:表示在模式匹配和静态模式规则中，代表目标模式中%的部分
    - `%`:表示文件名占位符，仅可在规则行使用

## 模式规则

当`make`进行自动匹配时，对于该条自定义模式规则(Pattern Rules)匹配成功，就会自动创建一条规则。

```Makefile
OBJS = $(patsubst %.c,%.o,$(wildcard *.c))
TARGET = world.out

$(TARGET): $(OBJS)
	cc -o $(TARGET) $(OBJS)

# 模式匹配规则：当make需要目标 xyz.o 时，自动生成一条 xyz.o: xyz.c 规则:
%.o: %.c
	@echo 'compiling $<...'
	cc -c -o $@ $<

clean:
	rm -f *.o $(TARGET)
```

自动生成的规则为如下：

```Makefile
hello.o: hello.c
	@echo 'compiling $<...'
	cc -c -o $@ $<
```

*隐式规则*:  由于`Makefile`编写之初就是为自动化构建C语言，所以它会自动将所需的`@.o`从同名`@.c`中寻找并编译。

## 自动依赖生成

自动制定依赖项，无需每次在命令中指定依赖。

```Makefile
# 列出所有 .c 文件:
SRCS = $(wildcard *.c)

# 根据SRCS生成 .o 文件列表:
OBJS = $(SRCS:.c=.o)

# 根据SRCS生成 .d 文件列表:
DEPS = $(SRCS:.c=.d)

TARGET = world.out

# 默认目标:
$(TARGET): $(OBJS)
	$(CC) -o $@ $^

# xyz.d 的规则由 xyz.c 生成:
%.d: %.c
	rm -f $@; \
	$(CC) -MM $< >$@.tmp; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.tmp > $@; \
	rm -f $@.tmp

# 模式规则:
%.o: %.c
	$(CC) -c -o $@ $<

clean:
	rm -rf *.o *.d $(TARGET)

# 引入所有 .d 文件:
include $(DEPS)
```

变量`$(SRCS)`通过扫描目录可以确定为`hello.c main.c`，因此，变量`$(OBJS)`赋值为`hello.o main.o`，变量`$(DEPS)`赋值为`hello.d main.d`。

通过`include $(DEPS)`引入`hello.d`和`main.d`文件，但是这两个文件一开始并不存在，不过，`make`通过模式规则匹配到`%.d: %.c`，这创造了一个机会，在这个模式规则内部，用`cc -MM`命令外加`sed`把`.d文件`创建出来。