以下列出目前项目中手簿使用的工具清单。

- typora (unix, win)
- xmind (unix, win)
- win-fonts (unix)
- clash-verge-rev-se (arch)

下面对需要执行破解操作的软件给出步骤。其余自行安装。

## `Typora`

### Linux版本

1. inject

```shell
cargo build --bin node-inject --release
mv target/release/node-inject /usr/share/typora
cd /usr/share/typora
sudo ./node-inject
```

2. generator a license

```shell
cargo run --bin license-gen --release
```

3. open typora and input your license.

### Windows版本

选择对应版本安装，并替换`winmm.dll`文件即可。

## `XMind`

### Linux版本

大客户版本激活

```shell
#打开系统配置文件
sudo vim /etc/profile
#写入系统参数
export VANA_LICENSE_MODE=true
export VANA_LICENSE_TO="Coffee Bean"
```

### Windows版本

选择对应版本安装后，禁止其联网即可。

### macOS版本

选择对应版本安装后，禁止其联网即可。
