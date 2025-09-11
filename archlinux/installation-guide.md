# **Arch Linux + Windows 双系统安装指南（UEFI）**

## **1. 准备阶段**

1. **备份重要数据**

   * Windows 系统、EFI 分区和用户数据都需要备份。
2. **制作 Arch Linux 安装 U盘**

   * 下载 Arch ISO → 使用 `Rufus`（Windows）或者 `dd`（Linux）写入 U盘。
   * 确保 U盘以 **UEFI 启动模式** 启动。
3. **关闭 Windows 快速启动和休眠**

   * 控制面板 → 电源选项 → 关闭快速启动
   * 防止 Windows 文件系统锁定导致 Arch 无法访问分区。
4. **空出一块磁盘用于安装 arch**
   
   * 值得注意的是，这块磁盘最好初始化为一个非 ntfs 并以英文进行命名，便于在 `lsblk` 中识别。如果你只是删除卷，那么在 `lsblk` 中是无法识别到的。

---

## **2. 启动到 Arch Linux 安装环境**

1. UEFI 模式启动 Arch Linux 安装 U盘。
2. 确认网络连通：

```bash
# 确认网卡名称
ip a # 名称基本都是 wlan0

# 使用 iwctl 工具进入交互式连接 wifi
iwctl
device list # 查看无线网卡名称
station wlan0 scan # 使用 wlan0 作为网卡扫描 WiFi
station wlan0 connect <wifiname>
<password>

# 确认是否联通
ping archlinux.org
```

3. 更新系统时钟：

```bash
timedatectl set-ntp true
```

---

## **3. 硬盘分区**

1. **查看磁盘分区**：

```bash
lsblk -pf
```

* Windows EFI 分区通常是 `~100~500MB`，FAT32。
* Windows 系统分区通常为 NTFS。
* 除为 arch 准备的分区外，可能还会存在一个 NTFS 的 Windows 恢复分区，尽量不要动它，除非你知道自己在干什么。

2. **为 Arch Linux 准备分区**：

   * 可以在 Windows 内置磁盘管理中压缩卷，为 Linux 留出未分配空间。
   * 常见分区：

     * `/` 根分区 (ext4, 20–50 GB, 由于本人日常使用，故留出 160G)
     * `/home` 分区 (ext4, 可选)
     * `swap` 分区或 swap 文件（最好选择 swap 文件，更加灵活，便于后期调整）
   * **不要新建 EFI 分区**，使用 Windows 的 EFI 分区即可。

---

## **4. 格式化并挂载分区**

```bash
# 假设分区如下：
# /dev/sda1 -> Windows EFI
# /dev/sda5 -> Arch root
# /dev/sda6 -> Arch home (可选)

# 不推荐将 /home 独立分区出来，不便管理。除非你知道自己在干什么。

# 格式化根分区磁盘
mkfs.ext4 /dev/sda5

# 挂载根分区
mount /dev/sda5 /mnt

# 挂载 home
mkdir /mnt/home
mount /dev/sda6 /mnt/home

# 挂载 Windows EFI 分区到 /mnt/boot
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

> **注意**：不要格式化 `/dev/sda1`，只挂载它。
>
> 此外，如果 Windows EFI 分区的结构如下所示：
> ```bash
> ❯ tree -L 2
> .
> ├── EFI
> │   ├── Boot
> │   ├── GRUB(x)
> │   └── Microsoft
> ├── PCM
> │   └── M3D
> └── System Volume Information
> 
> 8 directories, 0 files
> ```
> 那么，我推荐你将 Windows EFI 分区挂载到 `/mnt/boot/efi`
> 因为， `/boot` 中需要存储 linux 内核。

---

## **5. 安装基础系统**

在 LiveCD 中，事先将 Arch 中所需要使用到的，最基础的工具安装好。

```bash
pacstrap /mnt base linux linux-firmware vim nano zsh iwctl networkmanager
```

---

## **6. 配置系统**

1. **生成 fstab**：

    ```bash
    genfstab -U /mnt >> /mnt/etc/fstab
    ```

    简单说明一下 `fstab` 工具吧，它的全称是：`FileSystem Table`，它的作用是在计算机启动时，自动挂载磁盘。`Arch` 自身根所在磁盘和 `/boot/EFI` 都是在此自动挂载。

2. **切换到新系统**：

    ```bash
    arch-chroot /mnt
    # 想要退出到安装 LiveCD 中的话，直接执行以下命令
    exit
    ```

3. **设置时区**：

    ```bash
    ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
    hwclock --systohc
    ```

    其中， `... /Region/City` 切换为实际所在时区，例如：上海 (`... /Asia/Shanghai`)

4. **本地化**：

    ```bash
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    ```

    PS: 既然都使用 `Arch` 了，那么，咱就直接全英文启动吧。

5. **主机名与 hosts**：

    ```bash
    echo "archpc" > /etc/hostname
    ```

    ```bash
    vim /etc/hosts
    # 在打开的 vim 编辑器中输入如下配置以配置主机名
    127.0.0.1   localhost
    ::1         localhost
    127.0.1.1   archpc.localdomain archpc
    ```

6. **创建登陆用户**：

    1. 创建用户
        ```bash
        # 添加一个新用户
        useradd -m -G wheel -s /bin/zsh <username>

        # 设置密码
        passwd <yourpassword>
        ```

        创建完成后，`<username>` 会是你的 `Arch` 的默认登陆用户，密码为 `<yourpassword>` 。

        相关 `useradd` 命令的解释：
        - `-m`: 自动创建 home 目录 `/home/<username>`
        - `-G wheel`: 把用户加入 `wheel` 组（之后可以启用sudo）
        - `-s /bin/bash`: 指定默认 shell

    2. 启用sudo
        安装 `sudo` 并允许 `wheel` 组使用 sudo:
        ```bash
        pacman -S sudo
        EDIROR=vim visudo
        ```

        在打开的文件中取消该行注释：
        ```bash
        %wheel ALL=(ALL:ALL) ALL
        ```

        保存并退出后，`<username>` 即可使用 `sudo` 。
    
    > ![NOTE] 
    > 值得注意的是：
    >
    > 该流程中并未对 `root` 用户配置密码。这是合法，且安全的。系统会为 `root` 执行锁定操作。这是最佳实践。如果需要解锁 `root` 用户，可在系统安装完成后，自行搜索相关资料。

7. **配置 swap 交换空间**

    **注意**：此时，已经进入系统磁盘中了，不在 `LiveCD` 中！！！

    1. 开始创建 `swap.img` 交换文件
        ```bash
        # 创建 8GB 的 swap 文件，具体使用多大空间，自己上网搜搜
        fallocate -l 8G /swap.img

        # 或者用 dd（速度慢，但更通用）
        # dd if=/dev/zero of=/swap.img bs=1M count=8192

        # 设置正确权限（非常重要）
        chmod 600 /swap.img

        # 格式化为 swap
        mkswap /swap.img
        ```

    2. 在当前会话中激活 `swap`
        ```bash
        swapon /swap.img
        ```

    3. 配置开机自动挂载
        打开 `/etc/fstab` 并写入如下内容
        ```plaintext
        /swap.img   none    swap    defaults    0 0
        ```

8. **确认生成 初始化内存盘(initramfs)镜像**
    
    在安装 linux 内核时，已经自动将 `/boot/vmlinuz-linux` 安装至制定位置。通常情况下 初始化内存盘镜像 已经被自动生成。但仍然有缺失的可能性。

    请确认 `/boot` 目录下生成了如下两个文件：
    - `initramfs-linux.img`: 标准镜像，包含系统正常启动所需的基本模块。
    - `initramfs-linux-fallback.img`: 备用镜像，包含了几乎所有可用的模块，体积更大。是标准镜像的回退镜像。
    
    以下为手动生成方式。
    ```bash
    mkinitcpio -P
    ```

    > 如有缺失，在系统启动时会进入 `emergency shell` 模式，通常情况下，其中并没有 `mkinitcpio` 工具，可使用 LiveCD 再次挂载进入根，并生成。

---

## **7. 安装引导程序（UEFI）**

这里推荐 **GRUB**，也可以用 systemd-boot。

### **安装 GRUB**

1. 安装引导所需软件
    ```bash
    pacman -S grub efibootmgr os-prober
    ```

2. 按指定架构安装 GRUB
    ```bash
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
    ```

3. 编辑 `/etc/default/grub` 文件，启用 `os-prober`
    ```bash
    # 编辑 grub 文件
    sudo vim /etc/default/grub

    # 找到下行并取消注释（开启相关功能）
    GRUB_DISABLE_OS_PROBER=false
    ```

4. 生成配置文件
    ```bash
    grub-mkconfig -o /boot/grub/grub.cfg
    ```

> GRUB 会自动检测 Windows 并加入启动菜单。

---

## **8. 启用网络管理**

```bash
systemctl enable NetworkManager
```

---

## **9. 完成安装，退出并重启**

```bash
exit
umount -R /mnt # 采用递归方式卸载磁盘
umount -Rl /mnt # 如果繁忙，可采用懒卸载强制卸载，在进程释放完毕后即可自动卸载
# swapoff -a # 如果有启用 swap 分区（本次安装中没有，故不用担心）
reboot
```

重启时，进入 BIOS/UEFI 启动顺序，确保 **GRUB 启动项**在第一位。
GRUB 菜单中应该能看到：

* Arch Linux
* Windows Boot Manager

---

## **10. 安装后可选操作**

1. 安装图形界面：

    ```bash
    pacman -S xorg xorg-xinit gnome gdm
    systemctl enable gdm
    ```

    启用 gdm：
    ```bash
    systemctl enable gdm
    systemctl start gdm
    ```

2. 优化系统、安装驱动等。

    相关信息可参考[系统优化](/system-optimization.md)、[驱动安装](/about-drivers.md).