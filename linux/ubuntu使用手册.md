Linux中的常用命令及目录收录

# Linux文件树结构介绍

Linux 的目录结构采用树状结构，所有文件和目录都从根目录 (`/`) 开始。每个目录都有其特定的用途和内容。下面是 Linux 文件系统中主要目录的介绍：

- **`/` (根目录)**：文件系统的顶层目录。所有其他目录和文件都是从根目录派生的。

- **`/bin`**：存放系统启动和运行所需的基本命令和实用程序（如 `ls`、`cp`、`mv`、`rm`）。这些命令通常在单用户模式下也可以使用。

- **`/boot`**：包含启动 Linux 系统所需的文件，如内核文件 (`vmlinuz`)、引导加载程序 (`grub`)、初始 RAM 磁盘映像 (`initrd` 或 `initramfs`)。

- **`/dev`**：包含系统中的设备文件，这些文件代表设备驱动程序（如磁盘驱动器、终端、打印机等）。

- **`/etc`**：存放系统配置文件和管理脚本，如 `/etc/passwd`（用户账户信息）、`/etc/fstab`（文件系统表）、`/etc/hostname`（主机名）等。

- **`/home`**：包含所有用户的个人目录。每个用户在这里有一个子目录，如 `/home/username`。这是用户存储个人文件和配置的地方。

- **`/lib`**：存放系统运行所需的共享库文件，这些库文件支持 `/bin` 和 `/sbin` 目录中的可执行文件。

- **`/media`**：主要用于挂载可移动媒体设备（如 CD-ROM、USB 驱动器）的挂载点。

- **`/mnt`**：用于临时挂载文件系统。例如，管理员可能会在这里挂载外部存储设备。

- **`/opt`**：用于安装附加的应用程序软件包，这些软件包不是操作系统默认的。例如，第三方应用程序和软件通常安装在这里。

- **`/proc`**：一个虚拟文件系统，包含系统内核和进程的信息。例如 `/proc/cpuinfo`（CPU 信息）、`/proc/meminfo`（内存信息）。这些文件不实际存在于磁盘上，而是内核动态生成的。

- **`/root`**：超级用户（`root` 用户）的家目录。这个目录与普通用户的家目录不同，位于根目录下。

- **`/run`**：存放系统运行时数据，包含在系统启动时创建的临时文件，如 PID 文件和套接字文件。

- **`/sbin`**：存放系统管理员使用的基本命令和实用程序，如 `ifconfig`、`shutdown`、`mount` 等。普通用户通常没有权限执行这些命令。

- **`/srv`**：包含服务提供的数据，如 HTTP、FTP 服务的数据文件。用于存放服务提供的资源。

- **`/sys`**：一个虚拟文件系统，提供关于内核、硬件设备及其驱动的信息。与 `/proc` 类似，系统运行时动态生成内容。

- **`/tmp`**：用于存储临时文件。系统重启时，这个目录通常会被清空。

- **`/usr`**：存放系统程序和库的文件。通常包括：
  - **`/usr/bin`**：大多数用户命令的二进制文件。
  - **`/usr/lib`**：共享库文件。
  - **`/usr/local`**：安装的本地应用程序和库，通常由用户自己安装的程序存放在这里。
  - **`/usr/share`**：共享的数据文件，如文档、图标等。

- **`/var`**：存储可变数据文件，如日志文件 (`/var/log`)、邮件数据 (`/var/mail`)、缓存文件 (`/var/cache`)、临时文件 (`/var/tmp`) 等。

# Linux中的常用命令

## 1. 文件管理类

- 文件夹操作

  ```shell
  #转换工作文件夹
  cd /home/username/
  #
  ```

## 2. 文件操作类

### 2.1 解压缩

# Linux中的常用文件夹收录

## 1. 主文件目录

主文件目录，即`home`目录，它的实际目录为`/home/username/`

## 2. 个人软件配置信息存放汇总

大多个人软件配置信息都存放在`home`文件夹下，以`.<filename>`的形式隐藏存放，以下列出目前常见的配置文件

**文件**:

- `.zshrc`：存放`zsh`的环境变量等
- `.bashrc`：存放`bash`的环境变量等
- `.xprofile`：存放`x`相关的系统环境变量、启动程序、个性化设置（如触控板滚动条问题）
- `.vimrc`：存放`vim`相关的配置信息
- `/etc/apt/source.list`：存放软件包管理器`apt`中的源
- `/etc/default/grub`：存放`grub`的配置信息

**文件夹**:

- `~/home/.local/share/applications/`：存放个人的`<application>.desktop`快捷启动方式
- `/usr/share/applications/`：存放系统的`<application>.desktop`快捷启动方式
- `/etc/apt/source.list.d/`：与`source.list`一致，都是存放软件包管理器的源的，但`source.list.d/`中存放着多个第三方`<source>.list`

## 3. 文件的书写格式

以下将会对个别常用配置文件的配置信息书写格式进行列举

### `.desktop`

`.desktop` 文件是用于在 Linux 桌面环境中创建快捷方式或启动器的标准文件格式。它们通常用于在桌面环境（如 GNOME、KDE、XFCE 等）中创建应用程序的启动图标。下面是 `.desktop` 文件的书写格式和常见内容：

#### 基本结构

`.desktop` 文件是一个文本文件，通常包含以下几个部分：

1. **文件头**

   ```plaintext
   [Desktop Entry]
   ```

   这是所有 `.desktop` 文件的开头部分，标识该文件是一个桌面条目。

2. **必需字段**
   - **`Name`**: 应用程序的显示名称。

     ```plaintext
     Name=My Application
     ```

   - **`Exec`**: 启动应用程序时执行的命令。

     ```plaintext
     Exec=/usr/bin/myapp
     ```

   - **`Icon`**: 应用程序的图标路径（通常是图标文件的路径或图标主题中的图标名称）。

     ```plaintext
     Icon=myapp-icon
     ```

   - **`Type`**: 指定条目的类型，通常为 `Application`（应用程序）、`Link`（链接）、或 `Directory`（目录）。应用程序快捷方式使用 `Application`。

     ```plaintext
     Type=Application
     ```

3. **可选字段**
   - **`Comment`**: 对应用程序的简短描述。

     ```plaintext
     Comment=This is my application.
     ```

   - **`Terminal`**: 是否在终端中启动应用程序，`true` 或 `false`。

     ```plaintext
     Terminal=false
     ```

   - **`Categories`**: 用于在应用程序菜单中分类应用程序。例如：

     ```plaintext
     Categories=Utility;Development;
     ```

   - **`StartupNotify`**: 是否显示启动通知，`true` 或 `false`。

     ```plaintext
     StartupNotify=true
     ```

   - **`Actions`**: 定义额外的操作，通常用于在右键菜单中添加自定义动作。

     ```plaintext
     Actions=NewWindow;OpenFile;
     ```

#### 示例 `.desktop` 文件

```plaintext
[Desktop Entry]
Name=My Application
Comment=This is my application.
Exec=/usr/bin/myapp %F
Icon=myapp-icon
Terminal=false
Type=Application
Categories=Utility;Development;
```

#### 备注

- **路径**: `Exec` 和 `Icon` 字段的路径可以是绝对路径，也可以是相对路径。如果使用相对路径，应该是相对于用户的主目录。
- **占位符**: `Exec` 字段中的 `%F` 是一个占位符，表示打开的文件。你可以根据需要使用其他占位符，如 `%U`（URL）或 `%d`（目录）。

`.desktop` 文件通常放置在以下目录中：

- 用户的桌面目录：`~/Desktop/`
- 用户的应用程序菜单目录：`~/.local/share/applications/`
- 系统级别的应用程序菜单目录：`/usr/share/applications/`
