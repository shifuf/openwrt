# iStoreOS 集成指南

本指南说明如何在你的 JDCloud AX1800 Pro 上使用 iStoreOS。

## 什么是 iStoreOS？

iStoreOS 是基于 OpenWrt 的系统，提供了：

- **iStore** - 应用商店，可以轻松安装各种软件
- **iStoreX** - 扩展商店，提供更多应用
- **QuickStart** - 快速配置向导
- **用户友好界面** - 更现代化的 Web 界面

## 如何启用 iStoreOS

### 方法 1: 使用 iStoreOS 专用工作流（推荐）

1. 在 GitHub Actions 中选择 **"Build OpenWrt with iStoreOS"** 工作流
2. 确保 `enable_istoreos` 选项为 `true`
3. 运行编译

### 方法 2: 在配置文件中手动启用

编辑 `config/qualcommax_ipq60xx.config`，添加：

```bash
# iStoreOS Support
CONFIG_PACKAGE_luci-app-store=y
CONFIG_PACKAGE_luci-app-istorex=y
CONFIG_PACKAGE_luci-app-quickstart=y
CONFIG_PACKAGE_luci-app-quickstart-www=y
CONFIG_PACKAGE_luci-app-ttyd=y
```

## iStoreOS 包含的软件包

### 核心应用
- **iStore** (`luci-app-store`) - 主应用商店
- **iStoreX** (`luci-app-istorex`) - 扩展应用商店
- **QuickStart** (`luci-app-quickstart`) - 快速配置向导
- **TTYd** (`luci-app-ttyd`) - Web 终端

### 推荐通过 iStore 安装的软件
刷机后，你可以通过 iStore 安装：

- **OpenClash** - 代理工具
- **AdGuard Home** - 广告过滤
- **Docker** - 容器支持
- **Home Assistant** - 智能家居
- **Transmission** - BT 下载
- **Aria2** - 下载工具
- **qBittorrent** - BT 下载
- **Jellyfin** - 媒体服务器
- **Nextcloud** - 私有云
- **WireGuard** - VPN
- **ZeroTier** - 异地组网

## 配置说明

### 禁用中文语言包

为了确保编译成功，我们禁用了中文语言包：

```bash
# CONFIG_PACKAGE_luci-i18n-base-zh-cn is not set
# CONFIG_PACKAGE_luci-i18n-ttyd-zh-cn is not set
# CONFIG_PACKAGE_luci-i18n-passwall-zh-cn is not set
# CONFIG_PACKAGE_luci-i18n-istorex-zh-cn is not set
```

**原因**：
- 中文语言包在某些编译环境中不可用
- 可能导致依赖错误
- 禁用后可以使用英文界面

**如果需要中文**：
- 刷机后通过 iStore 或 opkg 安装中文语言包
- 或者在 SSH 中运行：
  ```bash
  opkg update
  opkg install luci-i18n-base-zh-cn
  ```

## 使用 iStoreOS

### 首次启动

1. 刷机后，访问 http://192.168.1.1
2. 首次登录需要设置 root 密码
3. QuickStart 向导会自动启动
4. 按照向导配置网络

### 安装应用

1. 在 LuCI 界面中，找到 **iStore** 菜单
2. 浏览可用应用
3. 点击安装按钮
4. 等待安装完成

### 通过 SSH 安装应用

```bash
# 更新软件源
opkg update

# 搜索应用
opkg list | grep -i "关键词"

# 安装应用
opkg install 应用名

# 例如：安装 OpenClash
opkg install luci-app-openclash
```

## 推荐的软件包组合

### 基础代理 + iStoreOS
```bash
# iStoreOS
CONFIG_PACKAGE_luci-app-store=y
CONFIG_PACKAGE_luci-app-istorex=y
CONFIG_PACKAGE_luci-app-quickstart=y

# PassWall
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y
```

### 完整功能 + iStoreOS
```bash
# iStoreOS
CONFIG_PACKAGE_luci-app-store=y
CONFIG_PACKAGE_luci-app-istorex=y
CONFIG_PACKAGE_luci-app-quickstart=y

# PassWall
CONFIG_PACKAGE_luci-app-passwall=y

# 其他
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-samba4=y
```

## 故障排除

### iStoreOS 安装失败

如果编译时 iStoreOS 相关包安装失败：

1. 检查编译日志中的错误信息
2. 确保 kiddin9 软件源可用
3. 尝试禁用 iStoreOS，使用基础配置

### 依赖问题

如果遇到依赖错误：

```bash
# 在配置中禁用问题包
# CONFIG_PACKAGE_luci-app-istorex is not set
# CONFIG_PACKAGE_luci-i18n-ttyd-zh-cn is not set
```

### 刷机后 iStore 无法使用

1. 检查网络连接
2. 更新软件源：
   ```bash
   opkg update
   ```
3. 检查是否有足够的存储空间

## iStoreOS vs 标准 OpenWrt

| 功能 | iStoreOS | 标准 OpenWrt |
|------|----------|--------------|
| 应用商店 | ✅ 内置 iStore | ❌ 需要手动安装 |
| 快速配置 | ✅ QuickStart | ❌ 手动配置 |
| Web 终端 | ✅ 内置 TTYd | ❌ 需要手动安装 |
| 界面 | 更现代化 | 标准 LuCI |
| 稳定性 | 可能稍低 | 更稳定 |
| 固件大小 | 更大 | 更小 |

## 推荐配置

### 稳定优先（推荐）
使用标准 OpenWrt + PassWall，刷机后通过 iStore 安装其他应用。

### 便利优先
使用 iStoreOS 配置，所有应用出厂即有。

## 相关链接

- [iStoreOS 官网](https://www.istoreos.com/)
- [iStoreOS GitHub](https://github.com/istoreos/istoreos)
- [kiddin9 软件源](https://github.com/kiddin9/openwrt-packages)
- [PassWall](https://github.com/xiaorouji/openwrt-passwall)

## 注意事项

1. **固件大小**：iStoreOS 会增加固件大小
2. **稳定性**：某些 iStoreOS 包可能不稳定
3. **依赖问题**：部分包可能有依赖冲突
4. **更新**：iStoreOS 包可能更新较慢

## 建议

如果你是第一次使用：
1. 先使用标准配置编译
2. 确保基础功能正常
3. 再尝试添加 iStoreOS

如果你需要中文界面：
1. 编译时禁用中文语言包
2. 刷机后通过 opkg 安装
3. 或者使用 iStore 安装语言包
