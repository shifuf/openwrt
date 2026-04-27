# 使用指南 - JDCloud AX1800 Pro 自定义固件编译

**OpenWrt 版本**: v25.12.2 (最新稳定版)

**软件源**:
- OpenWrt: https://github.com/openwrt/openwrt
- PassWall: https://github.com/Openwrt-Passwall/openwrt-passwall
- iStoreOS: https://github.com/kiddin9/openwrt-packages

## 快速开始

### 1. 准备工作

1. 在 GitHub 上 Fork 这个仓库
2. 克隆到本地：
   ```bash
   git clone https://github.com/你的用户名/openwrt-builder.git
   cd openwrt-builder
   ```

### 2. 选择编译方式

#### 方式 A: 基础编译（推荐新手）
- 使用默认配置
- 包含 PassWall + iStoreOS
- 适合快速上手

#### 方式 B: 自定义编译
- 添加更多软件包
- 修改配置文件
- 适合有经验的用户

### 3. 开始编译

在 GitHub Actions 中：
1. 选择 **"Build OpenWrt with iStoreOS for JDCloud AX1800 Pro"** 工作流
2. 点击 **Run workflow**
3. 等待 4-8 小时编译完成
4. 下载编译好的固件

### 4. 刷机

1. 通过 U-Boot 刷入固件
2. 访问 http://192.168.1.1
3. 设置密码并配置网络

---

## 默认包含的软件包

### iStoreOS 应用生态
- ✅ **iStore** - 应用商店
- ✅ **iStoreX** - 扩展商店
- ✅ **QuickStart** - 快速配置
- ✅ **TTYd** - Web 终端

### 代理工具
- ✅ **PassWall** - 支持 Xray、Trojan、Shadowsocks 等

### 系统工具
- ✅ htop, nano, curl, wget
- ✅ 完整的 LuCI Web 界面
- ✅ Argon 现代化主题

### 硬件支持
- ✅ WiFi 6 (ath11k)
- ✅ NSS 网络加速
- ✅ USB 3.0
- ✅ 文件系统支持 (ext4, f2fs, vfat, ntfs3, exfat)

---

## 自定义软件包

### 添加软件包

编辑 `config/qualcommax_ipq60xx.config`，在文件末尾添加：

```bash
# 例如：添加 OpenClash
CONFIG_PACKAGE_luci-app-openclash=y

# 例如：添加 DDNS
CONFIG_PACKAGE_luci-app-ddns=y

# 例如：添加 Samba 文件共享
CONFIG_PACKAGE_luci-app-samba4=y
```

### 常用软件包

#### 代理增强
```bash
CONFIG_PACKAGE_luci-app-openclash=y      # OpenClash
CONFIG_PACKAGE_luci-app-ssr-plus=y      # SSR Plus
CONFIG_PACKAGE_luci-app-vssr=y          # VSSR
```

#### 广告过滤
```bash
CONFIG_PACKAGE_luci-app-adguardhome=y   # AdGuard Home
CONFIG_PACKAGE_luci-app-adblock=y       # Adblock
```

#### VPN
```bash
CONFIG_PACKAGE_luci-app-zerotier=y      # ZeroTier
CONFIG_PACKAGE_luci-app-tailscale=y     # Tailscale
CONFIG_PACKAGE_luci-app-wireguard=y     # WireGuard
```

#### 网络工具
```bash
CONFIG_PACKAGE_luci-app-ddns=y          # 动态 DNS
CONFIG_PACKAGE_luci-app-sqm=y           # QoS 流量控制
```

#### 文件共享
```bash
CONFIG_PACKAGE_luci-app-samba4=y        # SMB 文件共享
CONFIG_PACKAGE_luci-app-aria2=y         # Aria2 下载
CONFIG_PACKAGE_luci-app-transmission=y  # BT 下载
```

---

## iStoreOS 使用说明

### 首次启动

1. 访问 http://192.168.1.1
2. 首次登录设置 root 密码
3. QuickStart 向导自动启动
4. 按照向导配置网络

### 安装应用

通过 iStore 安装：
1. 在 LuCI 菜单找到 **iStore**
2. 浏览应用列表
3. 点击安装

通过 SSH 安装：
```bash
# 更新软件源
opkg update

# 搜索应用
opkg list | grep 关键词

# 安装应用
opkg install 应用名

# 例如：安装中文语言包
opkg install luci-i18n-base-zh-cn
```

---

## 编译选项

### iStoreOS 选项

在 GitHub Actions 运行时，可以选择：

- **openwrt_version**: OpenWrt 版本（默认 v23.05.3）
- **enable_istoreos**: 是否启用 iStoreOS（默认 true）

### 工作流选择

- **Build OpenWrt for JDCloud AX1800 Pro**: 基础编译
- **Build OpenWrt with iStoreOS**: 包含 iStoreOS 的完整编译

---

## 故障排除

### 编译失败

1. 查看 Actions 日志
2. 检查软件包名称是否正确
3. 检查是否有依赖问题
4. 禁用有问题的软件包

### 依赖问题

如果遇到类似错误：
```
pkg_hash_check_unresolved: cannot find dependency luci-i18n-ttyd-zh-cn
```

在配置文件中禁用：
```bash
# CONFIG_PACKAGE_luci-i18n-base-zh-cn is not set
# CONFIG_PACKAGE_luci-i18n-ttyd-zh-cn is not set
```

### 刷机失败

1. 确认固件文件完整
2. 检查 U-Boot 版本
3. 尝试使用官方固件恢复

### iStoreOS 无法使用

```bash
# 更新软件源
opkg update

# 检查网络连接
ping www.baidu.com

# 重新安装
opkg install luci-app-store
```

---

## 推荐配置

### 基础代理配置（最稳定）
```bash
# iStoreOS
CONFIG_PACKAGE_luci-app-store=y
CONFIG_PACKAGE_luci-app-istorex=y
CONFIG_PACKAGE_luci-app-quickstart=y

# PassWall
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y

# 网络
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-ddns=y
```

### 完整功能配置
```bash
# iStoreOS
CONFIG_PACKAGE_luci-app-store=y
CONFIG_PACKAGE_luci-app-istorex=y
CONFIG_PACKAGE_luci-app-quickstart=y

# PassWall
CONFIG_PACKAGE_luci-app-passwall=y

# 其他
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-app-adguardhome=y
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-samba4=y
CONFIG_PACKAGE_luci-app-zerotier=y
```

---

## 更新固件

### 方法 1: 重新编译

1. 同步上游仓库
2. 运行 Actions 编译
3. 下载新固件
4. 通过 U-Boot 刷入

### 方法 2: 在线更新（推荐）

通过 iStore 或 opkg：
```bash
opkg update
opkg list-upgradable
opkg upgrade 包名
```

---

## 技术支持

- 查看 [README.md](README.md) 了解详细说明
- 查看 [PACKAGES.md](PACKAGES.md) 了解所有软件包
- 查看 [ISTOREOS-GUIDE.md](ISTOREOS-GUIDE.md) 了解 iStoreOS 详情
- 查看 [QUICKSTART.md](QUICKSTART.md) 了解快速开始

---

## 注意事项

1. **编译时间**：首次编译需要 4-8 小时
2. **固件大小**：iStoreOS 会增加固件大小
3. **稳定性**：新添加的软件包可能不稳定
4. **中文支持**：默认禁用中文，刷机后可手动安装
5. **备份**：编译成功后，备份你的配置文件

---

## 下一步

1. ✅ Fork 仓库
2. ✅ 选择编译方式
3. ✅ 开始编译
4. ✅ 下载固件
5. ✅ 刷机
6. ✅ 享受你的专属 OpenWrt！

**祝你使用愉快！** 🚀
