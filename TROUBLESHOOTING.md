# 故障排除指南

本文档帮助你解决编译过程中可能遇到的问题。

## 编译失败：Clone OpenWrt source

### 错误信息
```
Process completed with exit code 25
```

### 原因
- 指定的 OpenWrt 版本/分支不存在
- GitHub 访问问题
- 网络连接问题

### 解决方案

#### 方案 1：使用 main 分支（推荐）

在运行工作流时，将 `openwrt_branch` 设置为 `main`：
- **openwrt_branch**: `main`

#### 方案 2：使用已知的稳定版本

使用以下已知的稳定版本标签：
- `v23.05.3` - OpenWrt 23.05.3
- `v23.05.2` - OpenWrt 23.05.2
- `openwrt-23.05` - OpenWrt 23.05 系列
- `main` - 最新开发版本

#### 方案 3：检查可用版本

访问以下链接查看可用的版本：
- https://github.com/openwrt/openwrt/tags
- https://github.com/openwrt/openwrt/branches

---

## Node.js 20 弃用警告

### 警告信息
```
Node.js 20 actions are deprecated. The following actions are running on Node.js 20...
```

### 原因
这是 GitHub Actions 的警告，不是致命错误。工作流仍然会运行。

### 解决方案

#### 方案 1：忽略警告（推荐）
这个警告不影响编译，可以安全忽略。

#### 方案 2：设置环境变量
在工作流中添加：
```yaml
env:
  ACTIONS_ALLOW_USE_UNSECURE_NODE_VERSION: true
```

#### 方案 3：等待 GitHub 更新
GitHub 会在 2026 年自动迁移到 Node.js 24。

---

## 编译失败：Download packages

### 错误信息
```
make download failed
```

### 原因
- 网络连接问题
- 软件包源不可用
- 依赖问题

### 解决方案

#### 方案 1：重试编译
有时候网络问题会导致下载失败，重试即可。

#### 方案 2：减少软件包
禁用一些不必要的软件包，减少依赖。

#### 方案 3：检查网络
确保 GitHub Actions 环境可以访问互联网。

---

## 编译失败：Build firmware

### 错误信息
```
make failed
```

### 原因
- 软件包依赖问题
- 配置错误
- 内存不足

### 解决方案

#### 方案 1：查看构建日志
下载 `build-logs` artifact，查看详细的错误信息。

#### 方案 2：减少软件包
禁用可能导致问题的软件包：
```bash
# CONFIG_PACKAGE_问题包名 is not set
```

#### 方案 3：使用单核编译
工作流已配置自动降级到单核编译。

---

## 依赖问题

### 错误信息
```
pkg_hash_check_unresolved: cannot find dependency xxx
```

### 原因
- 中文语言包不可用
- 软件包依赖配置错误

### 解决方案

#### 方案 1：禁用中文语言包
在配置文件中添加：
```bash
# CONFIG_PACKAGE_luci-i18n-base-zh-cn is not set
# CONFIG_PACKAGE_luci-i18n-ttyd-zh-cn is not set
# CONFIG_PACKAGE_luci-i18n-passwall-zh-cn is not set
```

#### 方案 2：禁用问题软件包
禁用导致依赖问题的软件包。

#### 方案 3：使用稳定版本
使用已知稳定的 OpenWrt 版本。

---

## iStoreOS 相关问题

### 错误信息
```
kiddin9 feed update failed
```

### 原因
- kiddin9 软件源不可用
- 网络问题

### 解决方案

#### 方案 1：禁用 iStoreOS
在运行工作流时，将 `enable_istoreos` 设置为 `false`。

#### 方案 2：重试编译
有时候软件源会临时不可用。

#### 方案 3：使用其他源
可以尝试使用其他 iStoreOS 源（如果有的话）。

---

## PassWall 相关问题

### 错误信息
```
passwall feed update failed
```

### 原因
- PassWall 软件源不可用
- 网络问题

### 解决方案

#### 方案 1：重试编译
PassWall 源通常很稳定，重试可能解决问题。

#### 方案 2：检查源地址
确保使用正确的 PassWall 源：
```
https://github.com/Openwrt-Passwall/openwrt-passwall.git
```

#### 方案 3：禁用 PassWall
如果不需要，可以禁用 PassWall。

---

## 磁盘空间不足

### 错误信息
```
No space left on device
```

### 原因
- OpenWrt 编译需要大量磁盘空间
- GitHub Actions 限制

### 解决方案

#### 方案 1：减少软件包
禁用不必要的软件包，减少编译产物大小。

#### 方案 2：清理磁盘
工作流已包含磁盘清理步骤。

#### 方案 3：使用更大的 runner
考虑使用 GitHub Actions 的付费版本。

---

## 编译超时

### 错误信息
```
The job running on runner has exceeded the maximum execution time
```

### 原因
- 编译时间过长
- 超时限制

### 解决方案

#### 方案 1：减少软件包
减少软件包可以显著缩短编译时间。

#### 方案 2：使用缓存
启用 GitHub Actions 缓存。

#### 方案 3：增加超时时间
在工作流中增加 `timeout-minutes`。

---

## 刷机失败

### 错误信息
- 无法进入 U-Boot
- 刷机过程中断
- 刷机后无法启动

### 原因
- 固件文件损坏
- U-Boot 版本不兼容
- 刷机方法错误

### 解决方案

#### 方案 1：验证固件文件
下载后检查 MD5 或 SHA256。

#### 方案 2：使用官方固件恢复
如果刷机失败，使用官方固件恢复。

#### 方案 3：检查 U-Boot 版本
确保 U-Boot 版本兼容。

---

## iStoreOS 无法使用

### 错误信息
- iStore 无法打开
- 应用安装失败
- 网络错误

### 原因
- 网络连接问题
- 软件源不可用
- 配置错误

### 解决方案

#### 方案 1：更新软件源
```bash
opkg update
```

#### 方案 2：检查网络
```bash
ping www.baidu.com
```

#### 方案 3：重新安装
```bash
opkg install luci-app-store
```

---

## 获取帮助

### 查看日志

1. **Actions 日志** - 在 GitHub Actions 页面查看实时日志
2. **Build logs** - 下载 `build-logs` artifact
3. **系统日志** - 刷机后查看 `/tmp/log/messages`

### 提交 Issue

如果问题无法解决，请提交 Issue 并提供：
1. 错误信息
2. 使用的 OpenWrt 版本
3. 配置文件内容
4. Actions 日志

### 社区支持

- OpenWrt 官方论坛
- PassWall GitHub Issues
- iStoreOS 社区

---

## 预防措施

### 编译前

1. ✅ 检查 OpenWrt 版本是否存在
2. ✅ 使用 `main` 分支或已知稳定版本
3. ✅ 减少不必要的软件包
4. ✅ 确保网络连接稳定

### 编译中

1. ✅ 监控编译进度
2. ✅ 查看日志输出
3. ✅ 不要关闭浏览器

### 编译后

1. ✅ 下载并验证固件
2. ✅ 查看编译日志
3. ✅ 备份配置文件

---

## 常见问题 FAQ

### Q: 为什么选择 main 分支？
**A**: main 分支包含最新的代码，虽然可能不稳定，但通常可用。

### Q: 如何知道 OpenWrt 的最新版本？
**A**: 访问 https://github.com/openwrt/openwrt/tags 查看。

### Q: 编译需要多长时间？
**A**: 通常 4-8 小时，取决于软件包数量和 GitHub Actions 队列。

### Q: 可以本地编译吗？
**A**: 可以，但需要配置编译环境，推荐使用 GitHub Actions。

### Q: 如何更新到新版本？
**A**: Fork 最新版本，合并配置，重新编译。

---

## 联系方式

如有问题，请通过以下方式联系：
- GitHub Issues
- 社区论坛
- 邮件列表

---

## 更新日志

### 2024-XX-XX
- 添加故障排除指南
- 修复工作流文件
- 优化错误处理

---

**最后更新**: 2024-XX-XX
**版本**: 1.0
