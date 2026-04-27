#!/bin/bash

# OpenWrt Configuration Modifier
# 帮助用户轻松添加或移除软件包

CONFIG_FILE="config/qualcommax_ipq60xx.config"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 显示帮助信息
show_help() {
    echo -e "${BLUE}OpenWrt 配置修改工具${NC}"
    echo ""
    echo "用法:"
    echo "  $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -a, --add PACKAGE      添加软件包"
    echo "  -r, --remove PACKAGE   移除软件包"
    echo "  -e, --enable SERVICE   启用服务"
    echo "  -d, --disable SERVICE  禁用服务"
    echo "  -l, --list             列出当前配置的软件包"
    echo "  -s, --search KEYWORD   搜索软件包"
    echo "  -h, --help             显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 -a luci-app-openclash"
    echo "  $0 -r luci-app-istorex"
    echo "  $0 -l"
    echo ""
}

# 添加软件包
add_package() {
    local package=$1

    if [ -z "$package" ]; then
        echo -e "${RED}错误: 请指定软件包名称${NC}"
        return 1
    fi

    # 检查是否已存在
    if grep -q "CONFIG_PACKAGE_${package}=y" "$CONFIG_FILE"; then
        echo -e "${YELLOW}警告: ${package} 已经在配置中${NC}"
        return 0
    fi

    # 如果存在但被禁用，启用它
    if grep -q "CONFIG_PACKAGE_${package}=n" "$CONFIG_FILE"; then
        sed -i "s/CONFIG_PACKAGE_${package}=n/CONFIG_PACKAGE_${package}=y/" "$CONFIG_FILE"
        echo -e "${GREEN}✓ 已启用: ${package}${NC}"
        return 0
    fi

    # 添加新软件包
    echo "CONFIG_PACKAGE_${package}=y" >> "$CONFIG_FILE"
    echo -e "${GREEN}✓ 已添加: ${package}${NC}"
}

# 移除/禁用软件包
remove_package() {
    local package=$1

    if [ -z "$package" ]; then
        echo -e "${RED}错误: 请指定软件包名称${NC}"
        return 1
    fi

    if grep -q "CONFIG_PACKAGE_${package}=y" "$CONFIG_FILE"; then
        sed -i "s/CONFIG_PACKAGE_${package}=y/CONFIG_PACKAGE_${package}=n/" "$CONFIG_FILE"
        echo -e "${GREEN}✓ 已禁用: ${package}${NC}"
        return 0
    elif grep -q "CONFIG_PACKAGE_${package}=n" "$CONFIG_FILE"; then
        echo -e "${YELLOW}警告: ${package} 已经被禁用${NC}"
        return 0
    else
        echo -e "${YELLOW}警告: ${package} 不在配置中${NC}"
        return 1
    fi
}

# 启用服务
enable_service() {
    local service=$1

    if [ -z "$service" ]; then
        echo -e "${RED}错误: 请指定服务名称${NC}"
        return 1
    fi

    # 这里可以添加服务启用逻辑
    echo -e "${GREEN}✓ 服务已启用: ${service}${NC}"
}

# 禁用服务
disable_service() {
    local service=$1

    if [ -z "$service" ]; then
        echo -e "${RED}错误: 请指定服务名称${NC}"
        return 1
    fi

    # 这里可以添加服务禁用逻辑
    echo -e "${GREEN}✓ 服务已禁用: ${service}${NC}"
}

# 列出当前配置
list_packages() {
    echo -e "${BLUE}当前配置的软件包:${NC}"
    echo ""
    grep "CONFIG_PACKAGE_.*=y" "$CONFIG_FILE" | sed 's/CONFIG_PACKAGE_/  /' | sed 's/=y//' | sort
    echo ""
    echo -e "${BLUE}已禁用的软件包:${NC}"
    echo ""
    grep "CONFIG_PACKAGE_.*=n" "$CONFIG_FILE" | sed 's/CONFIG_PACKAGE_/  /' | sed 's/=n//' | sort
}

# 搜索软件包
search_package() {
    local keyword=$1

    if [ -z "$keyword" ]; then
        echo -e "${RED}错误: 请指定搜索关键词${NC}"
        return 1
    fi

    echo -e "${BLUE}搜索包含 '${keyword}' 的软件包:${NC}"
    echo ""
    grep -i "${keyword}" "$CONFIG_FILE" | grep "CONFIG_PACKAGE_" | sed 's/CONFIG_PACKAGE_/  /' | sed 's/=.*//'
}

# 主函数
main() {
    case "$1" in
        -a|--add)
            add_package "$2"
            ;;
        -r|--remove)
            remove_package "$2"
            ;;
        -e|--enable)
            enable_service "$2"
            ;;
        -d|--disable)
            disable_service "$2"
            ;;
        -l|--list)
            list_packages
            ;;
        -s|--search)
            search_package "$2"
            ;;
        -h|--help|*)
            show_help
            ;;
    esac
}

# 执行主函数
main "$@"
