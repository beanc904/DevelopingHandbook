Linux中的常用命令及目录收录

# Linux中的常用命令

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
