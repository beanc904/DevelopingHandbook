# 关于`Arch`的包管理器

## 本地脚本包的安装

通常来说，刚刚安装完 `Arch Linux` 使用包管理器安装本地文件，是会出现以下问题的。

```bash
archpc% makepkg -si --skippgpcheck --skipchecksums
==> ERROR: Cannot find the debugedit binary required for including source filesin debug packages.
==> ERROR: Cannot find the fakeroot binary.
```

这两个错误是 **离线安装 AUR 包常见的依赖缺失问题**.

### **缺失的软件包**

```
ERROR: Cannot find the debugedit binary
```

* `debugedit` 是 `pacman-contrib` 包里的工具
* 用于处理调试信息，如果不想生成调试包，可以忽略或安装它

```
ERROR: Cannot find the fakeroot binary
```

* `fakeroot` 是 `makepkg` 构建本地包时必须的工具
* 允许普通用户模拟 root 权限安装文件到 `${pkgdir}`
* 如果系统没有安装 `fakeroot`，就会报这个错

### **解决方法**

这些都是官方仓库包，可以用 pacman 安装：

```bash
sudo pacman -S --needed base-devel pacman-contrib fakeroot
```

* `base-devel` → 包含 makepkg、gcc、tar 等构建工具
* `pacman-contrib` → 包含 debugedit
* `fakeroot` → 构建包必需

## 相关包管理器

简单的三个系统包管理器介绍，可以参见[系统优化](/system-optimization.md).

### 使用`pacman`的镜像源

打开 `/etc/pacman.d/mirrorlist` 并于源列表最上方输入下列镜像仓库。其中，镜像源仓库存在优先级。

```bash
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
```

在配置完成镜像源后，使用 `sudo pacman -Syyu` 进行索引刷新。

> 该镜像源配置的是 `core` 与 `extra` 仓库的镜像源.

### 导入`archlinuxcn`仓库

打开 `/etc/pacman.conf` 并在末尾输入下列配置信息。

```bash
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

安装密钥配置工具，导入密钥包

```bash
pacman -Sy archlinuxcn-keyring
```

### 使用`brew`镜像源

于 `.zshrc` 中配置如下环境变量

```bash
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
```