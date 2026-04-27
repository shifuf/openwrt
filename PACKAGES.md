# 可用软件包列表

本文档列出了可以在 JDCloud AX1800 Pro 上使用的软件包。

## 代理工具

### PassWall 系列
```bash
# PassWall 核心
CONFIG_PACKAGE_luci-app-passwall=y

# PassWall 支持的协议
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_Plus=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Libev_Client=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Client=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Haproxy=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ChinaDNS_NG=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Dns2Socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Ipt2socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Microsocks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Plugin=y
```

### OpenClash
```bash
CONFIG_PACKAGE_luci-app-openclash=y
```

### SSR Plus
```bash
CONFIG_PACKAGE_luci-app-ssr-plus=y
```

### VSSR
```bash
CONFIG_PACKAGE_luci-app-vssr=y
```

## 应用商店

### iStore
```bash
CONFIG_PACKAGE_luci-app-store=y
```

### iStoreX (注意：可能有依赖问题)
```bash
# 谨慎使用，可能有中文语言包依赖问题
CONFIG_PACKAGE_luci-app-istorex=y
CONFIG_PACKAGE_luci-i18n-base-zh-cn=y
```

## 广告过滤

### AdGuard Home
```bash
CONFIG_PACKAGE_luci-app-adguardhome=y
```

### Adblock
```bash
CONFIG_PACKAGE_luci-app-adblock=y
```

### SmartDNS
```bash
CONFIG_PACKAGE_luci-app-smartdns=y
```

## VPN 和隧道

### ZeroTier
```bash
CONFIG_PACKAGE_luci-app-zerotier=y
```

### Tailscale
```bash
CONFIG_PACKAGE_luci-app-tailscale=y
```

### WireGuard
```bash
CONFIG_PACKAGE_luci-app-wireguard=y
CONFIG_PACKAGE_kmod-wireguard=y
CONFIG_PACKAGE_wireguard-tools=y
```

### OpenVPN
```bash
CONFIG_PACKAGE_luci-app-openvpn=y
CONFIG_PACKAGE_openvpn-openssl=y
```

### SoftEther VPN
```bash
CONFIG_PACKAGE_luci-app-softethervpn=y
```

## 网络工具

### DDNS (动态 DNS)
```bash
CONFIG_PACKAGE_luci-app-ddns=y
```

### UPnP
```bash
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_miniupnpd-nftables=y
```

### SQM QoS (流量控制)
```bash
CONFIG_PACKAGE_luci-app-sqm=y
```

### 网络唤醒
```bash
CONFIG_PACKAGE_luci-app-wol=y
```

### NTP 时间同步
```bash
CONFIG_PACKAGE_luci-app-ntpc=y
```

## 文件共享

### Samba4 (SMB/CIFS)
```bash
CONFIG_PACKAGE_luci-app-samba4=y
```

### FTP Server
```bash
CONFIG_PACKAGE_luci-app-vsftpd=y
```

### WebDAV
```bash
CONFIG_PACKAGE_luci-app-webdav=y
```

## 下载工具

### Transmission (BT)
```bash
CONFIG_PACKAGE_luci-app-transmission=y
```

### Aria2
```bash
CONFIG_PACKAGE_luci-app-aria2=y
```

### qBittorrent
```bash
CONFIG_PACKAGE_luci-app-qbittorrent=y
```

## 系统监控

### Netdata
```bash
CONFIG_PACKAGE_luci-app-netdata=y
```

### 系统资源监控
```bash
CONFIG_PACKAGE_luci-app-cpu-status=y
CONFIG_PACKAGE_luci-app-temp-status=y
```

### 多拨
```bash
CONFIG_PACKAGE_luci-app-mwan3=y
```

## 容器和虚拟化

### Docker 管理
```bash
CONFIG_PACKAGE_luci-app-dockerman=y
```

### KVM
```bash
CONFIG_PACKAGE_luci-app-kodexplorer=y
```

## 其他实用工具

### KMS 激活服务器
```bash
CONFIG_PACKAGE_luci-app-vlmcsd=y
```

### 访客网络
```bash
CONFIG_PACKAGE_luci-app-guest-wifi=y
```

### 定时任务
```bash
CONFIG_PACKAGE_luci-app-cron=y
```

### LED 控制
```bash
CONFIG_PACKAGE_luci-app-ledtrig-switch=y
```

### 文件管理器
```bash
CONFIG_PACKAGE_luci-app-filemanager=y
```

### 系统向导
```bash
CONFIG_PACKAGE_luci-app-wizard=y
```

### 风扇控制
```bash
CONFIG_PACKAGE_luci-app-fan=y
```

## 中文语言包

### 注意事项
中文语言包可能在某些编译环境中不可用，如果编译失败，尝试禁用：

```bash
# 禁用中文语言包（如果编译失败）
CONFIG_PACKAGE_luci-i18n-base-zh-cn=n
CONFIG_PACKAGE_luci-i18n-passwall-zh-cn=n
CONFIG_PACKAGE_luci-i18n-openclash-zh-cn=n
```

## 推荐配置组合

### 基础代理配置（最稳定）
```bash
# PassWall
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Client=y

# 网络
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_miniupnpd-nftables=y

# 系统
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_curl=y
```

### 完整功能配置
```bash
# 代理
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-openclash=y

# 广告过滤
CONFIG_PACKAGE_luci-app-adguardhome=y

# VPN
CONFIG_PACKAGE_luci-app-zerotier=y

# 网络
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-sqm=y

# 文件共享
CONFIG_PACKAGE_luci-app-samba4=y

# 监控
CONFIG_PACKAGE_luci-app-netdata=y

# 系统
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_luci-app-filemanager=y
CONFIG_PACKAGE_luci-app-fan=y
```

### 轻量级配置（适合低内存设备）
```bash
# 仅 PassWall
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y

# 基础网络
CONFIG_PACKAGE_luci-app-upnp=y

# 基础工具
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
```

## 软件包依赖说明

某些软件包有依赖关系，添加时需要注意：

- `luci-app-istorex` → 需要 `luci-i18n-ttyd-zh-cn`
- `luci-app-quickstart` → 需要 `luci-i18n-ttyd-zh-cn`
- `luci-app-openclash` → 需要多个依赖，可能增加固件大小
- `luci-app-dockerman` → 需要 Docker 支持，会显著增加固件大小

## 如何查找更多软件包

访问以下网址查找更多可用软件包：
- [OpenWrt 官方软件包](https://openwrt.org/packages)
- [PassWall 软件源](https://github.com/xiaorouji/openwrt-passwall)
- [OpenClash 软件源](https://github.com/vernesong/OpenClash)

## 注意事项

1. **软件包大小**：每个软件包都会增加固件大小，注意不要超过设备闪存容量
2. **依赖关系**：某些软件包有依赖，确保所有依赖都已启用
3. **编译时间**：添加更多软件包会增加编译时间
4. **稳定性**：新添加的软件包可能不稳定，建议先测试基础配置
5. **中文支持**：中文语言包可能在某些环境中不可用，如果编译失败尝试禁用
