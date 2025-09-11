## 软件包的安装

**Arch Linux**中主要存在如下三种包管理器：
- `pacman`: 官方提供的包管理器
- `paru`: AUR 仓库用包管理器（对 `pacman` 的二次封装，更加现代化）
- `yay`: AUR 仓库用包管理器（同 `paru`）

相关 AUR 软件包的安装管理，可详见：[AUR相关工具使用指南](/aur-tools.md).

## 桌面系统协议

追求日常使用，无脑 `Xorg` 协议。`Wayland` 虽然现代化，但许多第三方包存在各种兼容性问题。

## fcitx5的安装及使用

1. 安装相关软件包
   ```bash
   sudo pacman -S fcitx5 fcitx5-chinese-addons fcitx5-configtool
   ```

2. 打开 gui 配置界面，加入拼音
   ```bash
   fcitx5-config-qt
   ```
   在右侧选择框框中找到 `Pinyin` 并加入

3. 部分软件可能无法自动被 `fcitx5` 识别，并启用 pinyin 建议如下配置
   打开/创建 `.xprofile` 并键入
   ```bash
   export GTK_IM_MODULE=fcitx
   export QT_IM_MODULE=fcitx
   export XMODIFIERS=@im=fcitx
   ```

## `GitHub`的`ssh`远程连接

1. 生成 `rsa` 密钥
   使用自己的邮箱生成密钥
   ```bash
   ssh-keygen -t rsa -b 4096 -C "beanc904@outlook.com"
   ```

2. 将新生成的公钥添加至 `GitHub`
   ```bash
   vim ~/.ssh/id_*.pub
   ```

3. 验证连接
   ```bash
   ssh -T git@github.com
   ```

## GNOME插件

1. 插件管理器的安装
   ```bash
   sudo pacman -S gnome-shell-extensions gnome-tweaks
   ```

2. 浏览器插件集成工具
   ```bash
   sudo pacman -S gnome-browser-connector
   ```
   安装完成后，在 Firefox 等的插件商店搜索并安装插插件：gnome-shell-integration
   > 在 Debian/Ubuntu 等系统中，该包叫做 `chrome-gnome-shell`

3. ***常用插件***
- `AppIndicator and KStatusNotifierItem Support`: Ubuntu 提供的将托盘图标放置于 shell 栏右方的插件工具
- `Dash to Dock`: 自定义程序坞
- `Desktop Icons NG (DING)`: 桌面图标显示
- `GPU Profile Selector`: 工具栏中，显卡选择器
- `Input Method Panel`: 集成式输入法皮肤工具（功能很简陋，但是效果够现代）
- `Rounded Window Corners Reborn`: 桌面软件窗口圆角化
- `Vitals`: 计算机状态监控