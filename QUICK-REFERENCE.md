# 快速参考卡片

## 核心信息

| 项目 | 信息 |
|------|------|
| **设备** | JDCloud AX1800 Pro |
| **平台** | qualcommax/ipq60xx |
| **OpenWrt 版本** | v25.12.2 (最新稳定版) |
| **软件包数量** | 126 个 |
| **编译时间** | 4-8 小时 |

## 软件源

| 项目 | 仓库地址 |
|------|----------|
| **OpenWrt** | https://github.com/openwrt/openwrt |
| **PassWall** | https://github.com/Openwrt-Passwall/openwrt-passwall |
| **iStoreOS** | https://github.com/kiddin9/openwrt-packages |

## 快速开始

### 1. 推送代码

```bash
cd /d/Desktop/固件/openwrt-builder
git init
git add .
git commit -m "初始化 OpenWrt Builder"
git branch -M main
git remote add origin https://github.com/你的用户名/openwrt-builder.git
git push -u origin main
```

### 2. 运行编译

1. GitHub → Actions
2. 选择 **"Build OpenWrt with iStoreOS"**
3. 点击 **Run workflow**
4. 等待 4-8 小时
5. 下载固件

### 3. 刷机

1. 通过 U-Boot 刷入
2. 访问 http://192.168.1.1
3. 设置密码
4. 配置网络

## 默认软件包

### iStoreOS
- ✅ iStore - 应用商店
- ✅ iStoreX - 扩展商店
- ✅ QuickStart - 快速配置

### PassWall
- ✅ Xray, SingBox, Trojan
- ✅ Shadowsocks, Haproxy
- ✅ ChinaDNS-NG, Dns2Socks

### 系统
- ✅ LuCI Web 界面
- ✅ Argon 主题
- ✅ htop, nano, curl
- ✅ WiFi 6 (ath11k)
- ✅ NSS 网络加速

## 管理工具

### 配置修改

```bash
# 添加软件包
./scripts/modify-config.sh -a luci-app-openclash

# 移除软件包
./scripts/modify-config.sh -r luci-app-istorex

# 查看配置
./scripts/modify-config.sh -l

# 检查配置
./scripts/check-config.sh
```

### 常用软件包

```bash
# 代理增强
CONFIG_PACKAGE_luci-app-openclash=y

# 广告过滤
CONFIG_PACKAGE_luci-app-adguardhome=y

# VPN
CONFIG_PACKAGE_luci-app-zerotier=y

# 文件共享
CONFIG_PACKAGE_luci-app-samba4=y

# 网络工具
CONFIG_PACKAGE_luci-app-ddns=y
```

## 刷机后配置

### 首次启动

1. 访问 http://192.168.1.1
2. 设置 root 密码
3. QuickStart 向导启动
4. 配置网络

### 安装应用

```bash
# 更新软件源
opkg update

# 安装中文支持
opkg install luci-i18n-base-zh-cn

# 搜索应用
opkg list | grep 关键词

# 安装应用
opkg install 应用名
```

### 通过 iStore

1. LuCI 菜单 → iStore
2. 浏览应用
3. 点击安装

## 故障排除

### 编译失败

1. 查看 Actions 日志
2. 检查软件包名称
3. 禁用问题包
4. 重试编译

### 依赖问题

```bash
# 禁用问题包
# CONFIG_PACKAGE_问题包名 is not set
```

### 刷机失败

1. 检查固件完整性
2. 确认 U-Boot 版本
3. 使用官方固件恢复

### iStoreOS 问题

```bash
opkg update
opkg install luci-app-store
```

## 推荐配置

### 基础代理 (最稳定)

```bash
CONFIG_PACKAGE_luci-app-store=y
CONFIG_PACKAGE_luci-app-istorex=y
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y
CONFIG_PACKAGE_luci-app-upnp=y
```

### 完整功能

```bash
CONFIG_PACKAGE_luci-app-store=y
CONFIG_PACKAGE_luci-app-istorex=y
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-app-adguardhome=y
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-samba4=y
```

## 文档

| 文档 | 说明 |
|------|------|
| README.md | 项目说明 |
| QUICKSTART.md | 快速开始 |
| USAGE.md | 使用指南 |
| SOURCES.md | 软件源配置 |
| PACKAGES.md | 软件包列表 |
| CHANGELOG.md | 更新日志 |
| QUICK-REFERENCE.md | 本文件 |

## 关键链接

- OpenWrt: https://openwrt.org/
- PassWall: https://github.com/Openwrt-Passwall/openwrt-passwall
- iStoreOS: https://www.istoreos.com/

## 版本历史

### v1.1.0 (当前)
- OpenWrt v25.12.2
- 官方 PassWall 源
- iStoreOS 支持
- 126 个软件包

### v1.0.0
- 初始版本
- 基础功能

## 下一步

1. ✅ 推送代码
2. ✅ 运行编译
3. ✅ 下载固件
4. ✅ 刷机
5. ✅ 配置系统
6. ✅ 安装应用
7. ✅ 享受专属固件！

---

**最后更新**: 2024-XX-XX
**版本**: v1.1.0
**OpenWrt**: v25.12.2

**祝你使用愉快！** 🚀
