# Developing Handbook

## 目录

- [简介](#简介)
- [功能清单](#功能清单)
- [安装指南](#使用工具安装指南)
- [使用说明](#使用说明)
- [许可证](#许可证)
- [作者](#作者)
- [鸣谢](#鸣谢)

## 简介

本项目中包含`@beanc904`的所有开发相关的笔记，包括但不限于`Java`、`shell`、`git`等语言、脚本与工具的开发手簿。同时，其中还包含了该项目的使用方法，即周边工具链`(Typora 1.8.10)`等的下载与安装。

## 功能清单

以下列出目前已包含的开发语言脚本与系统的使用手簿。

- `Git`

  - [git使用手册](/git/git-using-handbook.md)
  - [git命令汇总](/git/git-command-overall.md)

- `Java`

  - [Java常用核心类库](/java/java-core-class-lib.md)

  - `jvm`

    - [堆栈的区分](/java/jvm/Heap-vs-Stack.md)
    - [jvm系统原理](/java/jvm/)

- `Linux`

  - [ubuntu发行版使用手册](/linux/ubuntu-using-handbook.md)
    - [linux文件树](/linux/linux-filetree-introduce.md)
    - [linux常用命令](/linux/linux-common-commands.md)
    - [linux常用配置](/linux/linux-common-configs.md)

- `Markdown`

  - [markdown使用手册](/markdown/markdown-base-grammar.md)

- `Shell`

  - [shell基本语法](/shell/shell-base-grammar.md)

- `Vim`

  - [vim使用手册](/vim/vim-using-handbook.md)

- `Regex`

  - [正则表达式基本语法](/regex/regex-base-grammar.md)

- `Makefile`

  - [Makefile基本语法](/makefile/makefile-base-grammar.md)

就目前为止，以上为项目中的手簿清单，后续将会对其进行更进一步的修正与更新。

## 使用工具安装指南

以下列出目前项目中手簿使用的工具清单。

- **`Typora`**：包含Linux、macOS、Windows版本
- **`XMind`**：包含Linux、macOS、Windows版本
- **`Visual Studio Code`**：包含Linux、macOS、Windows版本

下面将对工具进行安装与破解。

### `Typora`

#### Linux版本

首先使用`dpkg`进行软件的安装

```shell
sudo dpkg -i typora_<version>_amd64.deb
```

在安装完成后，进行破解工具的构建工作

```shell
#安装构建工具cargo，这里直接安装rust语言工具链
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#在安装完成后，开始构建工作
cargo build --bin node-inject --release
sudo mv target/release/node-inject /usr/share/typora
sudo mv Cargo.* /usr/share/typora
cd /usr/share/typora
sudo ./node-inject
#开始生成注册码
cargo run --bin license-gen --release
```

将生成的注册码粘贴到`Typora`中，其中，电子邮件可以随意填写。

#### Windows版本

选择对应版本安装，并替换`winmm.dll`文件即可。

#### macOS版本

选择对应版本安装即可。

### `XMind`

#### Linux版本

到本仓库的`release`中找到关于`XMind`的软件发布，下载对应的版本，暂只提供`Debian`分支的包，下载后进行常规软件安装。

```shell
sudo dpkg -i XMind-2020-for-Linux-amd-64bit-<version>.deb
```

开始大客户版本激活

```shell
#打开系统配置文件
sudo vim /etc/profile
#写入系统参数
export VANA_LICENSE_MODE=true
export VANA_LICENSE_TO="Coffee Bean"
```

#### Windows版本

选择对应版本安装后，禁止其联网即可。

#### macOS版本

选择对应版本安装后，禁止其联网即可。

### `Visual Studio Code`

访问[VS Code][1]官网

[1]:https://code.visualstudio.com

## 使用说明

将本项目克隆至本地

```shell
git clone https://github.com/beanc904/DevelopingHandbook.git
```

进入项目并开始阅读与使用

```shell
cd DevelopingHandbook/
```

## 许可证

该手簿项目使用[MIT 许可证](LICENSE)

## 作者

**beanc904**：[我的GitHub主页](https://github.com/beanc904)

## 鸣谢

- **DiamondHunters**: [NodeInject](https://github.com/DiamondHunters/NodeInject)用于Linux版本的`Typroa`破解
- **尚硅谷（宋红康）**: [JVM全套教程](https://www.bilibili.com/video/BV1PJ411n7xZ/)`jvm`笔记的自定义修订
- **youthlql**: [JavaYouth](https://github.com/youthlql/JavaYouth/tree/main/docs/JVM)fork其`jvm`笔记

## 注：

后续将不定期更新
