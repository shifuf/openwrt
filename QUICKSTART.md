# 快速开始指南

5 分钟内开始编译你的自定义 OpenWrt 固件！

## 第一步：Fork 仓库

1. 在 GitHub 上 Fork 这个仓库到你的账号

## 第二步：添加你的软件包

### 方法 1: 使用脚本（推荐）

```bash
# 克隆你 Fork 的仓库
git clone https://github.com/你的用户名/openwrt-builder.git
cd openwrt-builder

# 添加软件包
./scripts/modify-config.sh -a luci-app-openclash
./scripts/modify-config.sh -a luci-app-ddns

# 移除软件包
./scripts/modify-config.sh -r luci-app-istorex

# 查看当前配置
./scripts/modify-config.sh -l

# 提交更改
git add .
git commit -m "添加 OpenClash 和 DDNS"
git push
```

### 方法 2: 手动编辑配置文件

编辑 `config/qualcommax_ipq60xx.config`：

```bash
# 打开配置文件
nano config/qualcommax_ipq60xx.config

# 在文件末尾添加你想要的软件包
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_luci-app-samba4=y

# 保存并退出
# Ctrl + O, Enter, Ctrl + X

# 提交更改
git add .
git commit -m "更新软件包配置"
git push
```

## 第三步：触发编译

1. 进入你的 GitHub 仓库页面
2. 点击 **Actions** 标签
3. 在左侧选择 **Build OpenWrt for JDCloud AX1800 Pro**
4. 点击右侧的 **Run workflow** 按钮
5. 在弹出的窗口中，保持默认设置或选择你想要的 OpenWrt 版本
6. 点击绿色的 **Run workflow** 按钮

## 第四步：等待编译完成

编译过程通常需要 **2-4 小时**，你可以在 Actions 页面查看实时进度。

编译过程中会显示：
- ✅ 安装依赖
- ✅ 克隆 OpenWrt 源码
- ✅ 下载软件包
- ✅ 编译固件（这是最耗时的部分）
- ✅ 上传产物

## 第五步：下载固件

编译完成后：

1. 进入 **Actions** → 点击最新的编译任务（绿色 ✅ 标记）
2. 滚动到页面底部的 **Artifacts** 部分
3. 你会看到 `openwrt-jdcloud-ax1800-pro` 文件
4. 点击它来下载压缩包
5. 解压后你会看到 `.bin` 固件文件

## 第六步：刷机

### 准备工作
- 下载好的固件文件
- 一根网线连接电脑和路由器
- 路由器的 U-Boot 访问方式

### 刷机步骤
1. 将电脑 IP 设置为 192.168.1.x（例如 192.168.1.100）
2. 进入路由器的 U-Boot 界面
3. 选择刷机选项
4. 上传你下载的 `.bin` 文件
5. 等待刷机完成（不要断电！）
6. 路由器会自动重启

### 刷机后配置
1. 打开浏览器访问 http://192.168.1.1
2. 首次登录需要设置 root 密码
3. 在 **网络 → 接口** 中配置你的网络
4. 根据需要配置其他服务

## 常见问题

### Q: 编译失败了怎么办？

查看 Actions 日志，常见原因：
- 软件包名称拼写错误
- 软件包依赖问题
- 网络连接问题（重试即可）

### Q: 如何添加更多软件包？

编辑 `config/qualcommax_ipq60xx.config` 文件，添加：
```
CONFIG_PACKAGE_软件包名=y
```

然后提交并重新运行编译。

### Q: 固件太大怎么办？

- 减少不必要的软件包
- 使用更轻量级的替代品
- 禁用不需要的内核模块

### Q: 如何修改默认 IP 地址？

在配置文件中添加或修改：
```
CONFIG_TARGET_DEFAULT_IP="10.0.0.1"
```

### Q: 如何更新到新版本？

1. 在 GitHub 上同步上游仓库
2. 重新运行 Actions 编译
3. 下载新固件并刷入

## 下一步

- 查看 [PACKAGES.md](PACKAGES.md) 了解所有可用软件包
- 查看 [README.md](README.md) 了解详细配置
- 自定义你的固件配置
- 享受你的专属 OpenWrt！

## 需要帮助？

- 查看 [Issues](../../issues) 页面
- 搜索 OpenWrt 官方文档
- 在社区论坛提问

## 小技巧

1. **先测试基础配置**：第一次编译时只添加 PassWall，确保能正常工作
2. **逐步添加软件包**：不要一次添加太多，每次添加 2-3 个测试
3. **保存你的配置**：编译成功后，保存你的配置文件备份
4. **查看编译日志**：如果失败，仔细查看日志找出问题
5. **使用缓存**：GitHub Actions 会缓存编译结果，后续编译会更快

## 示例工作流程

```bash
# 1. Fork 并克隆仓库
git clone https://github.com/你的用户名/openwrt-builder.git
cd openwrt-builder

# 2. 添加你想要的软件包
echo "CONFIG_PACKAGE_luci-app-openclash=y" >> config/qualcommax_ipq60xx.config
echo "CONFIG_PACKAGE_luci-app-ddns=y" >> config/qualcommax_ipq60xx.config
echo "CONFIG_PACKAGE_luci-app-samba4=y" >> config/qualcommax_ipq60xx.config

# 3. 提交并推送
git add .
git commit -m "添加我的自定义软件包"
git push

# 4. 在 GitHub 上运行 Actions
# （按照上面的第三步操作）

# 5. 等待编译完成并下载固件
# 6. 刷机并享受你的专属固件！
```

**祝你编译顺利！** 🚀
