## 声卡驱动相关

1. 将相关用户添加至 `audio` 用户组
   
   1. 确认用户是否拥有访问 `audio` 的权限
        ```bash
        groups
        # 如果输出中没有 audio 群组，即无权
        ```

   2. 添加用户至 `audio` 群组
        ```bash
        sudo usermod -aG audio $USER
        ```

2. 安装相关服务

    ```bash
    sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack
    ```
    这是完整的音频支持包，其中包含了与 ALSA 和 PulseAudio 的兼容性。

3. 启动服务

    ```bash
    systemctl --user enable --now pipewire pipewire-pulse
    ```
    值得注意的是，这是用户级别的服务，无需使用 `sudo` 并且需要添加 `--user` .

## 蓝牙驱动相关

1. 安装蓝牙相关软件包
   ```bash
   sudo pacman -S bluez bluez-utils
   ```

2. 启用蓝牙服务
   ```bash
   sudo systemctl enable bluetooth
   sudo systemctl start bluetooth
   ```

3. 检查蓝牙设备
   ```bash
   bluetoothctl
   # 此时会进入交互式命令窗口
   # 输入 power on 来打开蓝牙
   # 检查是否可以正常扫描连接设备
   ```

## 显卡驱动相关

在 Arch Linux 上安装 NVIDIA RTX 2050 驱动，可以按照以下步骤进行：

### 1. 更新系统

首先，确保系统是最新的：

```bash
sudo pacman -Syu
```

### 2. 安装 NVIDIA 驱动

Arch Linux 的官方仓库包含了适用于 NVIDIA 显卡的驱动。可以使用以下命令安装驱动：

```bash
sudo pacman -S nvidia
```

这将安装最新的稳定版 NVIDIA 驱动，适用于 RTX 2050 显卡。如果你想安装 NVIDIA 的 LTS 驱动，可以选择安装 `nvidia-lts` 包。

### 3. 安装 NVIDIA 支持的库

如果需要额外的功能（例如 Vulkan 或 CUDA 支持），可以安装相关的 NVIDIA 库：

```bash
sudo pacman -S nvidia-utils
```

需要 Vulkan 支持，还可以安装：

```bash
sudo pacman -S vulkan-icd-loader nvidia-vulkan-utils
```

如果需要 Nvidia GUI 控制面板，可以安装：

```bash
sudo pacman -S nvidia-settings
```

### 4. 安装 `linux` 或 `linux-lts` 内核头文件

为了确保驱动能正确编译，需要安装内核头文件：

```bash
sudo pacman -S linux-headers
```

如果使用的是 LTS 内核：

```bash
sudo pacman -S linux-lts-headers
```

### 5. 更新 initramfs

安装完驱动之后，运行以下命令更新 `initramfs`：

```bash
sudo mkinitcpio -P
```

### 6. 启用 Nouveau 驱动（可选）

如果之前安装了开源的 Nouveau 驱动，需要禁用它，以避免与 NVIDIA 驱动冲突。可以通过以下命令禁用 Nouveau：

```bash
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
```

然后重新生成 initramfs：

```bash
sudo mkinitcpio -P
```

### 7. 重启系统

完成安装后，重启系统：

```bash
sudo reboot
```

### 8. 验证驱动是否正确安装

重启后，可以通过运行以下命令来验证 NVIDIA 驱动是否安装成功：

```bash
nvidia-smi
```

### 9. 配置 Xorg（可选）

如果遇到 Xorg 配置问题，可以使用 NVIDIA 提供的 `nvidia-xconfig` 工具生成 Xorg 配置文件：

```bash
sudo nvidia-xconfig
```

这将会自动配置 `xorg.conf` 文件。
