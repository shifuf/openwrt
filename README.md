# OpenWrt 自定义固件编译器

为 **JDCloud AX1800 Pro** (qualcommax/ipq60xx) 编译自定义 OpenWrt 固件。

**当前版本**: OpenWrt v25.12.2 (最新稳定版)

## 功能特点

✅ **完全可控** - 你可以自由选择需要的软件包

✅ **稳定可靠** - 使用官方 OpenWrt v25.12.2 源码，避免依赖问题

✅ **自动化编译** - 使用 GitHub Actions，无需本地编译环境

✅ **预配置优化** - 针对 JDCloud AX1800 Pro 优化的默认配置

✅ **最新版本** - 使用最新的 OpenWrt v25.12.2

## 软件源

| 项目 | 仓库地址 |
|------|----------|
| OpenWrt | https://github.com/openwrt/openwrt |
| PassWall | https://github.com/Openwrt-Passwall/openwrt-passwall |
| iStoreOS | https://github.com/kiddin9/openwrt-packages |

## 默认包含的软件包

### 核心功能
- **PassWall** - 代理工具（支持 Xray、Trojan、Shadowsocks 等）
- **LuCI** - Web 管理界面
- **Argon 主题** - 现代化界面主题

### 系统工具
- htop - 系统监控
- nano - 文本编辑器
- curl / wget - 下载工具
- ip-full - 网络工具
- iw / ethtool - 无线和以太网工具

### 文件系统支持
- ext4 / f2fs / vfat / ntfs3 / exfat
- USB 存储设备支持
- 自动挂载

### 网络功能
- dnsmasq-full (DHCP + DNS)
- miniupnpd (UPnP)
- 防火墙
- IPv6 支持

## 如何使用

### 步骤 1: Fork 仓库

1. 点击页面右上角的 **Fork** 按钮
2. 将仓库复制到你的 GitHub 账号下

### 步骤 2: 配置软件包

编辑 `config/qualcommax_ipq60xx.config` 文件来添加或移除软件包：

#### 添加新软件包

在配置文件中添加：
```
CONFIG_PACKAGE_软件包名=y
```

例如，添加 OpenClash：
```
CONFIG_PACKAGE_luci-app-openclash=y
```

#### 移除软件包

将 `=y` 改为 `=n`：
```
CONFIG_PACKAGE_软件包名=n
```

#### 常用软件包列表

**代理工具:**
- `luci-app-openclash` - OpenClash
- `luci-app-ssr-plus` - SSR Plus
- `luci-app-vssr` - VSSR

**应用商店:**
- `luci-app-store` - iStore 应用商店
- `luci-app-istorex` - iStoreX (注意：可能有依赖问题)

**广告过滤:**
- `luci-app-adguardhome` - AdGuard Home
- `luci-app-adblock` - Adblock

**网络工具:**
- `luci-app-ddns` - 动态 DNS
- `luci-app-vlmcsd` - KMS 激活
- `luci-app-dockerman` - Docker 管理

**系统监控:**
- `luci-app-zerotier` - ZeroTier VPN
- `luci-app-tailscale` - Tailscale VPN
- `luci-app-netdata` - Netdata 监控

**其他:**
- `luci-app-samba4` - SMB 文件共享
- `luci-app-transmission` - BT 下载
- `luci-app-aria2` - Aria2 下载

### 步骤 3: 修改网络配置（可选）

如果你需要修改默认 IP 地址或其他网络设置，编辑 `config/qualcommax_ipq60xx.config`，找到或添加：

```
CONFIG_TARGET_DEFAULT_IP="192.168.1.1"
CONFIG_TARGET_DEFAULT_NETMASK="255.255.255.0"
```

### 步骤 4: 触发编译

1. 进入你 Fork 的仓库
2. 点击 **Actions** 标签
3. 选择 **Build OpenWrt for JDCloud AX1800 Pro**
4. 点击 **Run workflow**
5. 选择 OpenWrt 版本（默认 v23.05.3）
6. 点击 **Run workflow** 开始编译

### 步骤 5: 下载固件

编译完成后（通常需要 2-4 小时）：

1. 进入 **Actions** → 最新的编译任务
2. 滚动到底部的 **Artifacts** 部分
3. 下载 `openwrt-jdcloud-ax1800-pro.zip`
4. 解压后找到 `.bin` 文件

## 刷机说明

### 通过 U-Boot 刷机

1. 下载编译好的固件（`.bin` 文件）
2. 进入 U-Boot 模式
3. 上传并刷入固件
4. 等待设备重启

### 默认配置

- **IP 地址**: 192.168.1.1
- **用户名**: root
- **密码**: 空（首次登录需要设置密码）
- **Web 界面**: http://192.168.1.1

## 故障排除

### 编译失败

如果编译失败，检查：

1. **Actions 日志** - 查看详细的错误信息
2. **软件包依赖** - 某些软件包可能有依赖问题
3. **配置文件语法** - 确保 `.config` 文件格式正确

### 软件包依赖问题

如果遇到类似 openwrt.ai 的依赖问题：

1. 移除有依赖问题的软件包
2. 使用更稳定的软件包组合
3. 检查 GitHub Issues 了解已知问题

### 刷机后无法启动

1. 检查固件文件是否完整
2. 确认使用了正确的刷机方法
3. 尝试使用官方固件恢复

## 推荐软件包组合

### 基础代理套装（推荐）
```
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-ddns=y
```

### 完整功能套装
```
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-app-adguardhome=y
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-zerotier=y
CONFIG_PACKAGE_luci-app-dockerman=y
```

### 轻量级套装（稳定优先）
```
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-upnp=y
```

## 更新日志

### 2024-XX-XX
- 初始版本
- 支持 JDCloud AX1800 Pro
- 包含 PassWall 和基础系统工具

## 许可证

MIT License

## 致谢

- [OpenWrt](https://openwrt.org/) - 开源路由器固件
- [PassWall](https://github.com/xiaorouji/openwrt-passwall) - 代理工具
- [Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt) - CI/CD 模板
