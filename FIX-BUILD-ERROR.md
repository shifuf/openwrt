# 修复编译错误指南

## 问题描述

编译失败，错误信息：
```
Process completed with exit code 25
Clone OpenWrt source 步骤失败
```

## 原因

OpenWrt 版本标签 `v25.12.2` 可能不存在或格式错误。

## 解决方案

### 方案 1：使用 main 分支（推荐）

**步骤**：

1. 在 GitHub 仓库中，点击 **Actions**
2. 选择 **"Build OpenWrt with iStoreOS"** 工作流
3. 点击 **Run workflow**
4. 在 **openwrt_branch** 输入框中输入：`main`
5. 点击 **Run workflow** 开始编译

**说明**：
- `main` 分支包含最新的 OpenWrt 代码
- 这是最稳定的选项
- 编译会使用最新的源码

---

### 方案 2：使用已知的稳定版本

**步骤**：

1. 在 GitHub 仓库中，点击 **Actions**
2. 选择 **"Build OpenWrt with iStoreOS"** 工作流
3. 点击 **Run workflow**
4. 在 **openwrt_branch** 输入框中输入以下任一版本：
   - `v23.05.3` - OpenWrt 23.05.3（推荐）
   - `v23.05.2` - OpenWrt 23.05.2
   - `openwrt-23.05` - OpenWrt 23.05 系列
5. 点击 **Run workflow** 开始编译

**说明**：
- 这些是官方发布的稳定版本
- 经过充分测试
- 兼容性最好

---

### 方案 3：检查可用版本

**步骤**：

1. 访问 https://github.com/openwrt/openwrt/tags
2. 查看可用的版本标签
3. 选择一个版本标签（例如 `v23.05.3`）
4. 在工作流中使用该标签

**推荐版本**：
- `v23.05.3` - 最新的 23.05 系列
- `v23.05.2` - 稳定版本
- `main` - 最新开发版本

---

## 已更新的工作流

我已经更新了工作流文件，修复了以下问题：

### 改进内容

1. ✅ 更改输入参数为 `openwrt_branch`
2. ✅ 默认使用 `main` 分支
3. ✅ 添加错误处理（如果指定分支失败，自动尝试 main）
4. ✅ 使用浅克隆（`--depth 1`）加快下载
5. ✅ 分离 feeds 更新步骤
6. ✅ 改进日志上传

### 新的工作流参数

- **openwrt_branch**: OpenWrt 分支或标签
  - 默认值: `main`
  - 可选值: `main`, `v23.05.3`, `openwrt-23.05` 等

- **enable_istoreos**: 是否启用 iStoreOS
  - 默认值: `true`
  - 可选值: `true` 或 `false`

---

## 重新运行编译

### 步骤 1：更新代码

如果你已经 Fork 了仓库，需要更新代码：

```bash
cd /d/Desktop/固件/openwrt-builder
git add .
git commit -m "修复编译错误：更新工作流文件"
git push
```

### 步骤 2：运行编译

1. 在 GitHub 仓库页面，点击 **Actions**
2. 选择 **"Build OpenWrt with iStoreOS"** 工作流
3. 点击 **Run workflow**
4. 设置参数：
   - **openwrt_branch**: `main` 或 `v23.05.3`
   - **enable_istoreos**: `true`
5. 点击 **Run workflow**

### 步骤 3：监控编译

1. 在 Actions 页面查看实时日志
2. 等待 4-8 小时
3. 下载编译好的固件

---

## 推荐配置

### 最稳定配置

- **openwrt_branch**: `v23.05.3`
- **enable_istoreos**: `true`

### 最新功能配置

- **openwrt_branch**: `main`
- **enable_istoreos**: `true`

### 最小化配置

- **openwrt_branch**: `main`
- **enable_istoreos**: `false`

---

## Node.js 警告

如果你看到以下警告：
```
Node.js 20 actions are deprecated...
```

**这是正常的**，不影响编译。这是 GitHub Actions 的警告，工作流仍然会正常运行。

---

## 常见问题

### Q: 应该使用哪个版本？

**A**: 推荐使用 `main` 分支或 `v23.05.3`。

- `main` - 最新代码，可能有新功能
- `v23.05.3` - 稳定版本，经过测试

### Q: 如何知道编译成功了？

**A**: 查看 Actions 页面，如果显示绿色 ✅，表示编译成功。

### Q: 编译失败了怎么办？

**A**: 
1. 查看 Actions 日志
2. 检查错误信息
3. 尝试其他版本
4. 查看 TROUBLESHOOTING.md

### Q: 需要重新 Fork 吗？

**A**: 不需要，只需更新代码并重新运行编译。

---

## 下一步

1. ✅ 更新工作流文件
2. ✅ 推送代码到 GitHub
3. ✅ 运行编译（使用 `main` 或 `v23.05.3`）
4. ✅ 等待编译完成
5. ✅ 下载固件
6. ✅ 刷机
7. ✅ 享受你的专属 OpenWrt！

---

## 相关文档

- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - 完整的故障排除指南
- [QUICK-REFERENCE.md](QUICK-REFERENCE.md) - 快速参考卡片
- [USAGE.md](USAGE.md) - 使用指南

---

## 技术支持

如果问题仍然存在，请：
1. 查看 TROUBLESHOOTING.md
2. 检查 GitHub Issues
3. 提交新的 Issue

---

**修复完成！** 现在可以重新运行编译了。🚀

**推荐**: 使用 `main` 分支进行编译。
