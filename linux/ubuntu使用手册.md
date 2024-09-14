# Ubuntu使用手册

## Linux文件树结构介绍

首先展示个人的根目录文件树。

```shell
.
├── bin -> usr/bin
├── bin.usr-is-merged
├── boot
├── cdrom
├── dev
├── etc
├── home
├── lib -> usr/lib
├── lib64 -> usr/lib64
├── lib.usr-is-merged
├── lost+found
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin -> usr/sbin
├── sbin.usr-is-merged
├── snap
├── srv
├── swap.img
├── sys
├── tmp
├── usr
└── var
```

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

## Linux中的常用命令

Ubuntu 常用命令介绍可以分为

- [系统管理](#1-系统管理类命令)
- [文件操作](#2-文件和目录操作类命令)
- [网络](#3-网络类命令)
- [软件管理](#4-软件管理类命令)
- [权限类](#5-文件权限和用户管理类命令)
- [搜索压缩类](#6-搜索和压缩类命令)

等几大类。以下是一些常用命令的介绍：

### 1. **系统管理类命令**

1. `sudo`: 以管理员身份执行命令。
  
  示例: `sudo apt update`

------

2. `reboot`: 重启系统。

- 示例: `sudo reboot`

------

3. `shutdown`: 关闭或重启系统。

- 示例: `sudo shutdown now` (立即关机), `sudo shutdown -r now` (立即重启)

------

4. `top`: 实时查看系统运行状态、进程。

------

5. `df`: 查看磁盘使用情况。

- 示例: `df -h` (以人类可读的格式显示)

------

6. `free`: 查看内存使用情况。

- 示例: `free -h`

------

7. `uname`: 显示系统信息。

- 示例: `uname -a` (显示详细的系统信息)

------

8. `fc-cache`: 字体管理类命令

- 示例: `fc-cache -vf ~/.fonts` (刷新处于~/.fonts的个人字体缓存)

### 2. **文件和目录操作类命令**

1. `ls`: 列出目录中的文件。

- 示例: `ls -l` (以列表形式显示文件)
- 参数问题: `-l`(以列表显示)`-a`(显示所有文件)

------

2. `cd`: 切换目录。

- 示例: `cd /home/user` (切换到指定目录)

------

3. `pwd`: 显示当前工作目录。

------

4. `mkdir`: 创建新目录。

- 示例: `mkdir myfolder`

------

5. `mount`: 挂载磁盘操作。

- 挂载:

  ```bash
  sudo mount </dev/> </mnt/>
  ```

- 卸载：

  ```bash
  sudo unmount </mnt/>
  ```

#### 2.5 `rm`命令的详细使用

- `rm`: 删除文件或目录。
  - 示例: `rm filename` (删除文件), `rm -r foldername` (删除目录及其内容)
  - 介绍: `rm` 是一个用于删除文件和目录的命令。它是非常强大的工具，因此在使用时需要小心，以避免误删除重要数据。以下是 `rm` 命令及其常用参数的介绍：

    - 基本语法

      ```bash
      rm [选项] 文件/目录
      ```

    - 常用选项

      - `-r` 或 `--recursive`: 递归删除目录及其内容。这是删除目录时必须使用的选项。
        - 示例: `rm -r myfolder`

      - `-f` 或 `--force`: 强制删除文件，不显示警告，也不要求确认。如果文件不存在，`rm` 也不会报错。
        - 示例: `rm -f myfile.txt`

      - `-i`: 在删除每个文件之前提示确认。这可以防止意外删除重要文件。
        - 示例: `rm -i myfile.txt`

      - `-I`: 在删除多个文件之前提示确认。这比 `-i` 更适用于删除多个文件或目录。
        - 示例: `rm -I *.txt`

      - `-v` 或 `--verbose`: 显示详细的删除过程。每个被删除的文件或目录都将被列出。
        - 示例: `rm -v myfile.txt`

      - `--no-preserve-root`: 当使用 `-r` 参数删除根目录时，不保留根目录。这是非常危险的操作，通常不推荐使用。
        - 示例: `rm -r --no-preserve-root /`

------

#### 2.6 `cp`命令的详细使用

- `cp`: 复制文件或目录。
  - 示例: `cp file1 file2` (复制文件), `cp -r dir1 dir2` (递归复制目录)
  - 介绍: `cp` 命令用于复制文件和目录。它非常有用，尤其是在需要创建文件或目录的副本时。以下是 `cp` 命令及其常用选项的介绍：

  - 基本语法

    ```bash
    cp [选项] 源文件 目标文件/目录
    ```

  - 常用选项

    - `-r` 或 `--recursive`: 递归复制目录及其内容。当复制目录时必须使用此选项。
      - 示例: `cp -r sourcedir targetdir`

    - `-i` 或 `--interactive`: 在覆盖目标文件之前提示确认。这可以防止意外覆盖重要文件。
      - 示例: `cp -i file1.txt file2.txt`

    - `-f` 或 `--force`: 强制覆盖目标文件。如果目标文件已经存在，`cp` 会强制覆盖它，而不提示用户。
      - 示例: `cp -f file1.txt file2.txt`

    - `-u` 或 `--update`: 仅在源文件比目标文件新或者目标文件不存在时才复制。这可以防止不必要的复制操作。
      - 示例: `cp -u file1.txt file2.txt`

    - `-v` 或 `--verbose`: 显示详细的复制过程。每个被复制的文件或目录都会被列出。
      - 示例: `cp -v file1.txt file2.txt`

    - `-a` 或 `--archive`: 以归档模式复制文件和目录。这等同于 `-dR --preserve=all`，即保留所有属性（包括符号链接、文件权限、时间戳等）并递归复制目录。
      - 示例: `cp -a sourcedir targetdir`

    - `--backup`: 备份目标文件。如果目标文件已存在，会创建一个备份副本。
      - 示例: `cp --backup file1.txt file2.txt`

------

7. `mv`: 移动或重命名文件。

- 示例: `mv oldname newname` (重命名), `mv file /path/to/destination` (移动文件)

### 3. **网络类命令**

1. `ping`: 测试网络连接。

- 示例: `ping google.com`

------

2. `ifconfig`: 查看或配置网络接口（已被 `ip` 命令取代）。

- 示例: `ifconfig` (显示网络接口信息)

------

3. `ip`: 查看或管理网络配置。

- 示例: `ip a` (查看网络接口)

------

4. `curl`: 获取或发送网络请求。

- 示例: `curl http://example.com`

------

5. `wget`: 下载文件。

- 示例: `wget http://example.com/file.zip`

------

6. `proxy_on\off`: 配置终端代理。

- 配置文件信息

 `.zshrc`和`.bashrc`中配置以下内容

 ```shell
 function proxy_on() {
  export http_proxy=http://127.0.0.1:<port>
  export https_proxy=http://127.0.0.1:<port>
  echo -e "终端代理已开启"
 }
 
 function proxy_off() {
  unset proxy_http proxy_https
  echo -e "终端代理已关闭"
 }
 ```

 终端刷新环境函数

 ```bash
 source .zshrc
 ```

- 测试网络连接

 跳转至`4.`使用`curl -I www.google.com`查看连接。

### 4. **软件管理类命令**

1. `apt`: Ubuntu 的包管理工具，常用于安装、更新和卸载软件。

- `apt update`: 更新软件源列表。
- `apt upgrade`: 升级已安装的软件包。
- `apt install`: 安装软件包。
  - 示例: `sudo apt install vim`
- `apt remove`: 卸载软件包。
  - 示例: `sudo apt remove package-name`

------

2. `dpkg`: 用于直接操作 `.deb` 包。

- 示例: `sudo dpkg -i package.deb` (安装软件包)

### 5. **文件权限和用户管理类命令**

#### 5.1 `chmod`: 修改文件权限

- `chmod`命令的
  - 示例: `chmod 755 file` (给予文件所有者读写执行权限，其他用户仅有读取和执行权限)

------

2. `chown`: 改变文件所有者。
  
- 示例: `chown user:group file`

------

3. `useradd`: 添加新用户。

- 示例: `sudo useradd -m newuser`

------

4. `passwd`: 修改用户密码。
  
- 示例: `sudo passwd username`

### 6. **搜索和压缩类命令**

1. `grep`: 在文件中搜索特定字符串。
  
- 示例: `grep 'search-term' filename`

------

2. `find`: 搜索文件和目录。
  
- 示例: `find /path -name filename`

#### 6.3 `tar`命令的详细使用

- `tar`: 压缩或解压 `.tar` 文件。
  - 示例: `tar -czvf archive.tar.gz /path/to/files` (创建压缩文件)
  - 介绍: `tar` 是一个用于创建和操作 tar 存档文件（.tar 文件）的命令。它可以用来打包多个文件和目录，通常与压缩工具（如 gzip 或 bzip2）一起使用。以下是 `tar` 命令的基本用法及其常用选项：

  - 基本语法

    ```bash
    tar [选项] [存档文件] [文件/目录]
    ```

  - 常用选项

    - **创建一个 tar 存档**：

      ```bash
      tar -cf archive.tar file1 file2 directory
      ```

      - `-c`：创建新的 tar 存档。
      - `-f`：指定存档文件的名称（`archive.tar`）。

    - **查看 tar 存档的内容**：

      ```bash
      tar -tf archive.tar
      ```

      - `-t`：列出存档文件中的内容。
      - `-f`：指定存档文件的名称（`archive.tar`）。

    - **解压 tar 存档**：

      ```bash
      tar -xf archive.tar
      ```

      - `-x`：解压存档。
      - `-f`：指定存档文件的名称（`archive.tar`）。

    - **创建一个 gzip 压缩的 tar 存档**：

      ```bash
      tar -czf archive.tar.gz file1 file2 directory
      ```

      - `-z`：通过 gzip 压缩。
      - `-c`、`-f` 选项如上所述。

    - **解压 gzip 压缩的 tar 存档**：

      ```bash
      tar -xzf archive.tar.gz
      ```

      - `-x`：解压存档。
      - `-z`：解压 gzip 压缩的存档。
      - `-f`：指定存档文件的名称（`archive.tar.gz`）。

    - **创建一个 bzip2 压缩的 tar 存档**：

      ```bash
      tar -cjf archive.tar.bz2 file1 file2 directory
      ```

      - `-j`：通过 bzip2 压缩。

    - **解压 bzip2 压缩的 tar 存档**：

      ```bash
      tar -xjf archive.tar.bz2
      ```

      - `-x`：解压存档。
      - `-j`：解压 bzip2 压缩的存档。

    - **创建一个 xz 压缩的 tar 存档**：

      ```bash
      tar -cJf archive.tar.xz file1 file2 directory
      ```

      - `-J`：通过 xz 压缩。

    - **解压 xz 压缩的 tar 存档**：

      ```bash
      tar -xJf archive.tar.xz
      ```

      - `-x`：解压存档。
      - `-J`：解压 xz 压缩的存档。

------

4. `zip/unzip`: 压缩和解压缩 `.zip` 文件。
  
- 示例: `zip -r archive.zip file1 file2` (压缩), `unzip archive.zip` (解压)

## Linux中的常用文件夹收录

### 1. 主文件目录

主文件目录，即`home`目录，它的实际目录为`/home/username/`

### 2. 个人软件配置信息存放汇总

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

### 3. 文件的书写格式

以下将会对个别常用配置文件的配置信息书写格式进行列举

#### `.desktop`

`.desktop` 文件是用于在 Linux 桌面环境中创建快捷方式或启动器的标准文件格式。它们通常用于在桌面环境（如 GNOME、KDE、XFCE 等）中创建应用程序的启动图标。下面是 `.desktop` 文件的书写格式和常见内容：

##### 基本结构

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

##### 示例 `.desktop` 文件

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

##### 备注

- **路径**: `Exec` 和 `Icon` 字段的路径可以是绝对路径，也可以是相对路径。如果使用相对路径，应该是相对于用户的主目录。
- **占位符**: `Exec` 字段中的 `%F` 是一个占位符，表示打开的文件。你可以根据需要使用其他占位符，如 `%U`（URL）或 `%d`（目录）。

`.desktop` 文件通常放置在以下目录中：

- 用户的桌面目录：`~/Desktop/`
- 用户的应用程序菜单目录：`~/.local/share/applications/`
- 系统级别的应用程序菜单目录：`/usr/share/applications/`
