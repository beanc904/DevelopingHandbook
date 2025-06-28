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
Linux 磁盘根目录（`/`）下的各个文件夹各有特定用途，且其命名多基于 UNIX 传统和 Filesystem Hierarchy Standard（FHS）规范。以下是常见目录的作用及其命名来源：

### 1. `/bin`（Binary）
   - **作用**：存放基本用户命令，如 `ls`、`cp`、`mv`、`cat` 等。这些是所有用户都能使用的基本可执行文件。
   - **命名来源**：`bin` 是 "binary"（二进制）的缩写，表示这里存放的是可执行二进制程序。

### 2. `/boot`（Boot）
   - **作用**：存放用于引导系统的文件，如 Linux 内核（`vmlinuz`）、`initrd`、`grub` 配置等。
   - **命名来源**：`boot` 代表 "bootstrapping"（引导过程），用于启动系统。

### 3. `/dev`（Devices）
   - **作用**：包含所有设备文件（如 `sda` 代表硬盘，`tty` 代表终端），Linux 设备文件通常映射到 `/dev`。
   - **命名来源**：`dev` 是 "device"（设备）的缩写，表示设备文件所在的目录。

### 4. `/etc`（Et Cetera）
   - **作用**：存放系统配置文件，如 `passwd`（用户信息）、`hosts`（主机名解析）、`fstab`（文件系统挂载）。
   - **命名来源**：`etc` 本意是 "et cetera"（等等），最初用于存放无法归类的文件，后来演变为专门存放配置文件。

### 5. `/home`（Home）
   - **作用**：存放普通用户的主目录，如 `/home/user`，用户的个人文件、配置、桌面文件等都存放在这里。
   - **命名来源**：`home` 直译为“家”，表示用户的“家目录”。

### 6. `/lib`（Library）
   - **作用**：存放系统运行所需的共享库文件（类似 Windows 的 DLL），以及内核模块（`/lib/modules`）。
   - **命名来源**：`lib` 是 "library"（库）的缩写，表示存放共享库文件。

### 7. `/media`（Media）
   - **作用**：用于自动挂载的可移动存储设备，如 USB 盘、CD-ROM 等，系统通常会在此目录下创建挂载点（如 `/media/usb`）。
   - **命名来源**：`media` 代表“媒介”，表示这里存放的是外部存储介质。

### 8. `/mnt`（Mount）
   - **作用**：用户手动挂载的文件系统临时挂载点。
   - **命名来源**：`mnt` 是 "mount"（挂载）的缩写，表示挂载点。

### 9. `/opt`（Optional）
   - **作用**：用于存放可选的软件包，如某些第三方软件（`/opt/google/chrome`）。
   - **命名来源**：`opt` 是 "optional"（可选）的缩写，表示可选软件。

### 10. `/proc`（Process）
   - **作用**：一个虚拟文件系统，存放进程及内核信息，如 `/proc/cpuinfo`（CPU 信息）。
   - **命名来源**：`proc` 是 "process"（进程）的缩写，表示进程相关的文件系统。

### 11. `/root`（Root）
   - **作用**：`root` 用户的主目录，类似于普通用户的 `/home/username`。
   - **命名来源**：`root` 代表超级用户（`root` 用户）。

### 12. `/run`（Run-time）
   - **作用**：存放系统运行时的数据，如 PID 文件、锁文件等，通常在系统重启后清空。
   - **命名来源**：`run` 代表“运行”，表示存放运行时数据。

### 13. `/sbin`（System Binary）
   - **作用**：存放系统管理员使用的基本命令，如 `shutdown`、`fdisk`、`ifconfig`。
   - **命名来源**：`sbin` 是 "system binary"（系统二进制）的缩写，表示系统管理相关的二进制文件。

### 14. `/srv`（Service）
   - **作用**：存放服务器提供的服务数据，如 HTTP 服务器的网页文件（`/srv/www`）。
   - **命名来源**：`srv` 是 "service"（服务）的缩写，表示服务相关数据。

### 15. `/sys`（System）
   - **作用**：一个虚拟文件系统，提供与 `/proc` 类似的功能，允许用户与内核交互。
   - **命名来源**：`sys` 是 "system"（系统）的缩写。

### 16. `/tmp`（Temporary）
   - **作用**：存放临时文件，通常系统重启后会清空。
   - **命名来源**：`tmp` 是 "temporary"（临时）的缩写，表示存放临时文件。

### 17. `/usr`（Unix System Resources）
   - **作用**：存放用户程序及库文件，如 `/usr/bin`（非必要可执行程序）、`/usr/lib`（非必要库文件）。
   - **命名来源**：最初 `usr` 代表“user”，后来演变为 "Unix System Resources"（UNIX 系统资源）。

### 18. `/var`（Variable）
   - **作用**：存放可变数据，如日志文件（`/var/log`）、邮件队列（`/var/mail`）。
   - **命名来源**：`var` 是 "variable"（可变的）的缩写，表示存放动态数据。

---

### **总结**
Linux 根目录结构基于 UNIX 传统和 FHS 规范，每个目录的命名都有历史沿革或直观意义：
- 直接反映用途（`/home`、`/boot`、`/tmp`）。
- 采用缩写（`/bin`、`/lib`、`/mnt`）。
- 代表系统管理（`/sbin`、`/etc`）。
- 反映 UNIX 传统（`/usr`、`/var`）。
