#!/bin/bash

# Kwrt/OpenWrt 配置检查脚本
# 检查配置文件是否包含所有必需的软件包

CONFIG_FILE="config/qualcommax_ipq60xx.config"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 计数器
TOTAL=0
FOUND=0
MISSING=0

# 检查软件包是否在配置中
check_package() {
    local package=$1
    local description=$2

    TOTAL=$((TOTAL + 1))

    if grep -q "CONFIG_PACKAGE_${package}=y" "$CONFIG_FILE"; then
        echo -e "${GREEN}✓${NC} $package - $description"
        FOUND=$((FOUND + 1))
    elif grep -q "^CONFIG_PACKAGE_${package}=n$" "$CONFIG_FILE" || grep -q "^# CONFIG_PACKAGE_${package} is not set$" "$CONFIG_FILE"; then
        echo -e "${YELLOW}○${NC} $package - $description (disabled)"
    else
        echo -e "${RED}✗${NC} $package - $description (missing)"
        MISSING=$((MISSING + 1))
    fi
}

echo -e "${BLUE}===================================${NC}"
echo -e "${BLUE}Kwrt/OpenWrt 配置检查${NC}"
echo -e "${BLUE}===================================${NC}"
echo ""

# 检查 PassWall 核心包
echo -e "${BLUE}PassWall 核心包:${NC}"
check_package "luci-app-passwall" "PassWall 主程序"
check_package "luci-app-passwall_INCLUDE_Xray" "Xray 核心"
check_package "luci-app-passwall_INCLUDE_SingBox" "SingBox 核心"
check_package "luci-app-passwall_INCLUDE_Shadowsocks_Rust_Client" "Shadowsocks Rust"
check_package "luci-app-passwall_INCLUDE_Trojan_Plus" "Trojan Plus"
check_package "luci-app-passwall_INCLUDE_Haproxy" "Haproxy 负载均衡"
check_package "luci-app-passwall_INCLUDE_ChinaDNS_NG" "ChinaDNS-NG"
check_package "luci-app-passwall_INCLUDE_Dns2Socks" "Dns2Socks"
check_package "luci-app-passwall_INCLUDE_Ipt2socks" "Ipt2Socks"
check_package "luci-app-passwall_INCLUDE_Microsocks" "Microsocks"
check_package "luci-app-passwall_INCLUDE_V2ray_Plugin" "V2ray Plugin"
echo ""

# 检查 LuCI 界面
echo -e "${BLUE}LuCI 界面:${NC}"
check_package "luci" "LuCI 核心"
check_package "luci-base" "LuCI 基础"
check_package "luci-compat" "LuCI 兼容层"
check_package "luci-app-firewall" "防火墙管理"
check_package "luci-app-upnp" "UPnP 管理"
check_package "luci-app-filemanager" "文件管理器"
check_package "luci-app-package-manager" "软件包管理"
check_package "luci-app-wifihistory" "WiFi 历史"
echo ""

# 检查系统核心
echo -e "${BLUE}系统核心:${NC}"
check_package "base-files" "基础文件系统"
check_package "bash" "Bash Shell"
check_package "dropbear" "SSH 服务器"
check_package "netifd" "网络接口守护进程"
check_package "fstools" "文件系统工具"
check_package "block-mount" "块设备挂载"
check_package "automount" "自动挂载"
check_package "opkg" "软件包管理器"
check_package "uci" "统一配置接口"
check_package "logd" "日志守护进程"
echo ""

# 检查系统工具
echo -e "${BLUE}系统工具:${NC}"
check_package "htop" "系统监控"
check_package "nano" "文本编辑器"
check_package "curl" "HTTP 客户端"
check_package "wget-ssl" "下载工具"
check_package "mtd" "MTD 工具"
check_package "coremark" "性能测试"
check_package "cpufreq" "CPU 频率控制"
check_package "autocore" "自动核心"
check_package "uboot-envtools" "U-Boot 环境变量"
check_package "resolveip" "IP 解析"
check_package "swconfig" "交换机配置"
echo ""

# 检查网络服务
echo -e "${BLUE}网络服务:${NC}"
check_package "dnsmasq-full" "DNS/DHCP 服务器"
check_package "odhcp6c" "IPv6 DHCP 客户端"
check_package "odhcpd-ipv6only" "IPv6 DHCP 服务器"
check_package "ppp" "PPP 协议"
check_package "ppp-mod-pppoe" "PPPoE 拨号"
check_package "ds-lite" "DS-Lite IPv6"
check_package "firewall4" "防火墙"
check_package "ca-bundle" "CA 证书"
check_package "libustream-mbedtls" "TLS 库"
check_package "uclient-fetch" "HTTP 客户端"
check_package "urandom-seed" "随机数种子"
check_package "urngd" "随机数生成器"
check_package "wpad-mbedtls" "无线认证"
echo ""

# 检查库文件
echo -e "${BLUE}库文件:${NC}"
check_package "libc" "C 标准库"
check_package "libgcc" "GCC 运行时库"
check_package "openssh-sftp-server" "SFTP 服务器"
check_package "zram-swap" "ZRAM 交换"
check_package "losetup" "循环设备"
echo ""

# 检查 WiFi 驱动
echo -e "${BLUE}WiFi 驱动:${NC}"
check_package "ath11k-firmware-ipq6018" "ath11k 固件"
check_package "ipq-wifi-jdcloud_re-ss-01" "设备 WiFi 配置"
check_package "kmod-ath11k" "ath11k 内核模块"
check_package "kmod-ath11k-ahb" "ath11k AHB 总线"
check_package "kmod-ath11k-pci" "ath11k PCI 总线"
echo ""

# 检查内核模块 - DSA
echo -e "${BLUE}内核模块 - DSA:${NC}"
check_package "kmod-dsa" "分布式交换架构"
check_package "kmod-dsa-qca8k" "QCA8K 交换机"
echo ""

# 检查内核模块 - 文件系统
echo -e "${BLUE}内核模块 - 文件系统:${NC}"
check_package "kmod-fs-ext4" "ext4 文件系统"
check_package "kmod-fs-f2fs" "f2fs 文件系统"
check_package "e2fsprogs" "ext4 工具"
check_package "f2fs-tools" "f2fs 工具"
echo ""

# 检查内核模块 - 硬件
echo -e "${BLUE}内核模块 - 硬件:${NC}"
check_package "kmod-gpio-button-hotplug" "GPIO 按钮"
check_package "kmod-leds-gpio" "GPIO LED"
check_package "kmod-leds-pwm" "PWM LED"
echo ""

# 检查内核模块 - 库
echo -e "${BLUE}内核模块 - 库:${NC}"
check_package "kmod-lib-zstd" "Zstandard 压缩"
echo ""

# 检查内核模块 - NSS
echo -e "${BLUE}内核模块 - NSS 网络加速:${NC}"
check_package "kmod-nss-ifb" "NSS IFB"
check_package "kmod-phy-aquantia" "Aquantia PHY"
check_package "kmod-phy-qca83xx" "QCA83xx PHY"
check_package "kmod-qca-nss-crypto" "NSS 加密"
check_package "kmod-qca-nss-dp" "NSS 数据平面"
check_package "kmod-qca-nss-drv" "NSS 驱动"
check_package "kmod-qca-nss-drv-bridge-mgr" "NSS 桥接管理"
check_package "kmod-qca-nss-drv-eogremgr" "NSS EoGRE 管理"
check_package "kmod-qca-nss-drv-gre" "NSS GRE"
check_package "kmod-qca-nss-drv-igs" "NSS IGS"
check_package "kmod-qca-nss-drv-l2tpv2" "NSS L2TPv2"
check_package "kmod-qca-nss-drv-lag-mgr" "NSS LAG 管理"
check_package "kmod-qca-nss-drv-map-t" "NSS MAP-T"
check_package "kmod-qca-nss-drv-match" "NSS 匹配"
check_package "kmod-qca-nss-drv-mirror" "NSS 镜像"
check_package "kmod-qca-nss-drv-netlink" "NSS Netlink"
check_package "kmod-qca-nss-drv-pppoe" "NSS PPPoE"
check_package "kmod-qca-nss-drv-pptp" "NSS PPTP"
check_package "kmod-qca-nss-drv-qdisc" "NSS QoS"
check_package "kmod-qca-nss-drv-tun6rd" "NSS 6rd 隧道"
check_package "kmod-qca-nss-drv-tunipip6" "NSS IPoIP6 隧道"
check_package "kmod-qca-nss-drv-vlan-mgr" "NSS VLAN 管理"
check_package "kmod-qca-nss-drv-vxlanmgr" "NSS VXLAN 管理"
check_package "kmod-qca-nss-drv-wifi-meshmgr" "NSS WiFi Mesh"
check_package "kmod-qca-nss-ecm" "NSS ECM"
check_package "nss-firmware-ipq60xx" "NSS 固件"
echo ""

# 检查内核模块 - TCP
echo -e "${BLUE}内核模块 - TCP:${NC}"
check_package "kmod-tcp-bbr" "BBR 拥塞控制"
echo ""

# 检查内核模块 - USB
echo -e "${BLUE}内核模块 - USB:${NC}"
check_package "kmod-usb3" "USB 3.0"
check_package "kmod-usb-dwc3" "DWC3 USB 控制器"
check_package "kmod-usb-dwc3-qcom" "Qualcomm DWC3"
echo ""

# 显示统计结果
echo -e "${BLUE}===================================${NC}"
echo -e "${BLUE}检查结果${NC}"
echo -e "${BLUE}===================================${NC}"
echo ""
echo -e "检查总数: ${BLUE}${TOTAL}${NC}"
echo -e "已找到:   ${GREEN}${FOUND}${NC}"
echo -e "缺失:     ${RED}${MISSING}${NC}"
echo ""

if [ $MISSING -eq 0 ]; then
    echo -e "${GREEN}✓ 配置完整！所有必需软件包都已包含。${NC}"
    exit 0
else
    echo -e "${RED}✗ 配置不完整！有 ${MISSING} 个软件包缺失。${NC}"
    echo ""
    echo -e "${YELLOW}请检查以下软件包是否需要添加到配置文件中：${NC}"
    echo ""
    grep "CONFIG_PACKAGE_.*=y" "$CONFIG_FILE" | wc -l
    echo " packages currently enabled"
    exit 1
fi
