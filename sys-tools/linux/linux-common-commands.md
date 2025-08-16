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
 # 多函数命令
 function proxy_on() {
  export http_proxy=http://127.0.0.1:<port>
  export https_proxy=http://127.0.0.1:<port>
  echo -e "终端代理已开启"
 }
 
 function proxy_off() {
  unset proxy_http proxy_https
  echo -e "终端代理已关闭"
 }

 # 单函数参数切换
 function proxy () {
    if [[ $1 == "on" ]]; then
        export http_proxy=http://127.0.0.1:<port>
        export https_proxy=http://127.0.0.1:<port>
        echo -e "终端代理已开启"
    fi
    if [[ $1 == "off" ]]; then
        unset http_proxy https_proxy
        echo -e "终端代理已关闭"
    fi
 }
 ```

 终端刷新环境函数

 ```bash
 source .zshrc
 ```

- 测试网络连接

 跳转至`4.`使用`curl -I www.google.com`查看连接。

- 使用`ssh`进行远程连接

  1. 服务软件`openssh-server`准备
    ```bash
    sudo apt install openssh-server
    ```
  2. 防火墙配置
    ```bash
    sudo ufw allow ssh
    sudo ufw enable
    ```
  3. 服务端`ssh`服务启动
    ```bash
    # 默认情况下监听服务ssh.socket是开启的，并且开机自启
    sudo systemctl start ssh        //启动服务ssh.server
    sudo systemctl start ssh.socket //启动服务ssh.socket
    sudo systemctl enable ssh       //设置开机自启
    sudo systemctl status ssh       //查看ssh服务状态
    ```
  4. 服务端IP查询
    ```bash
    ip a
    ```
  5. 客户端远程连接与断开
    ```bash
    ssh hostname@ipaddress          //连接
    exit                            //断开
    ```
  6. 服务端`ssh`服务关闭
    ```bash
    sudo systemctl stop ssh             //关闭ssh.server
    sudo systemctl disable ssh.socket   //关闭ssh.socket
    ```

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

