# 软件源配置

本文档列出了编译 OpenWrt 固件时使用的所有软件源。

## 主要软件源

### OpenWrt (核心系统)
- **仓库**: https://github.com/openwrt/openwrt
- **分支**: v25.12.2 (最新稳定版)
- **说明**: OpenWrt 官方源码

### PassWall (代理工具)
- **仓库**: https://github.com/Openwrt-Passwall/openwrt-passwall
- **分支**: main
- **说明**: PassWall 代理工具主仓库

### PassWall Packages (依赖包)
- **仓库**: https://github.com/Openwrt-Passwall/openwrt-passwall-packages
- **分支**: main
- **说明**: PassWall 依赖的软件包

### iStoreOS (应用商店)
- **仓库**: https://github.com/kiddin9/openwrt-packages
- **分支**: master
- **说明**: iStoreOS 应用商店软件包

## 在工作流中添加软件源

GitHub Actions 工作流会自动添加以下软件源：

```bash
# OpenWrt 官方源
git clone https://github.com/openwrt/openwrt.git -b v25.12.2

# PassWall 源
echo "src-git passwall https://github.com/Openwrt-Passwall/openwrt-passwall.git;main" >> feeds.conf.default
echo "src-git passwall-packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main" >> feeds.conf.default

# iStoreOS 源
echo "src-git kiddin9 https://github.com/kiddin9/openwrt-packages.git;master" >> feeds.conf.default
```

## 如何修改软件源

### 方法 1: 编辑工作流文件

编辑 `.github/workflows/build-openwrt-istoreos.yml`，修改软件源地址：

```yaml
- name: Clone OpenWrt source
  run: |
    git clone https://github.com/openwrt/openwrt.git -b v25.12.2 openwrt
    cd openwrt

    # Update feeds
    ./scripts/feeds update -a
    ./scripts/feeds install -a

    # Add custom feeds
    echo "src-git passwall https://github.com/Openwrt-Passwall/openwrt-passwall.git;main" >> feeds.conf.default
    echo "src-git kiddin9 https://github.com/kiddin9/openwrt-packages.git;master" >> feeds.conf.default

    # Update all feeds
    ./scripts/feeds update -a
    ./scripts/feeds install -a -p passwall
    ./scripts/feeds install -a -p kiddin9
```

### 方法 2: 使用其他 PassWall 源

如果需要使用其他 PassWall 源，可以替换为：

```bash
# 官方源（推荐）
echo "src-git passwall https://github.com/Openwrt-Passwall/openwrt-passwall.git;main" >> feeds.conf.default

# 备用源
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> feeds.conf.default
```

## 更新软件源

### 更新 OpenWrt 版本

修改工作流中的 `OPENWRT_VERSION` 环境变量：

```yaml
env:
  OPENWRT_VERSION: 'v25.12.2'  # 修改为新版本
```

### 更新 PassWall

PassWall 会自动从 main 分支拉取最新代码。

### 更新 iStoreOS

iStoreOS 会自动从 master 分支拉取最新代码。

## 验证软件源

### 检查软件源是否可用

```bash
# 测试 OpenWrt 源
git ls-remote https://github.com/openwrt/openwrt.git

# 测试 PassWall 源
git ls-remote https://github.com/Openwrt-Passwall/openwrt-passwall.git

# 测试 iStoreOS 源
git ls-remote https://github.com/kiddin9/openwrt-packages.git
```

### 检查分支是否存在

```bash
# 查看 OpenWrt 可用分支
git ls-remote --heads https://github.com/openwrt/openwrt.git | grep v25

# 查看 PassWall 可用分支
git ls-remote --heads https://github.com/Openwrt-Passwall/openwrt-passwall.git
```

## 常见问题

### Q: 软件源访问失败怎么办？

**解决方案**：
1. 检查网络连接
2. 使用镜像源（如果可用）
3. 重试编译
4. 检查仓库是否公开

### Q: 如何添加其他软件源？

编辑工作流文件，添加新的源：

```bash
echo "src-git 自定义名称 https://github.com/用户名/仓库.git;分支" >> feeds.conf.default
./scripts/feeds update 自定义名称
./scripts/feeds install -a -p 自定义名称
```

### Q: PassWall 源应该用哪个？

**推荐**：使用官方 PassWall 源
```bash
https://github.com/Openwrt-Passwall/openwrt-passwall.git
```

**原因**：
- 官方维护
- 更新及时
- 社区支持

### Q: iStoreOS 源是否安全？

**是的**，kiddin9 的软件源是 iStoreOS 官方源：
- https://github.com/kiddin9/openwrt-packages

## 版本兼容性

### OpenWrt v25.12.2

- ✅ 支持 JDCloud AX1800 Pro
- ✅ 支持 ath11k WiFi 6
- ✅ 支持 NSS 网络加速
- ✅ 支持最新的硬件驱动

### PassWall

- ✅ 支持 Xray
- ✅ 支持 SingBox
- ✅ 支持 Trojan
- ✅ 支持 Shadowsocks
- ✅ 支持 Haproxy

### iStoreOS

- ✅ iStore 应用商店
- ✅ iStoreX 扩展商店
- ✅ QuickStart 向导
- ✅ TTYd Web 终端

## 更新日志

### 2024-XX-XX
- 更新到 OpenWrt v25.12.2
- 使用官方 PassWall 源
- 添加 iStoreOS 支持

## 相关链接

- OpenWrt 官网: https://openwrt.org/
- OpenWrt GitHub: https://github.com/openwrt/openwrt
- PassWall GitHub: https://github.com/Openwrt-Passwall/openwrt-passwall
- iStoreOS 官网: https://www.istoreos.com/
- iStoreOS GitHub: https://github.com/istoreos/istoreos

## 贡献

如果你发现软件源有问题或有改进建议，请提交 Issue 或 Pull Request。

## 许可证

本文档遵循项目整体的 MIT 许可证。
