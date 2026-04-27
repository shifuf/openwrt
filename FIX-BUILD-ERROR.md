# 修复编译错误指南

## 问题描述

编译失败，错误信息：
```
Process completed with exit code 25
Update feeds 步骤失败
Unexpected input(s) 'force'
```

## 原因

这次失败至少有两个独立问题：

1. 工作流里的 `actions/checkout@v4` 使用了不存在的参数 `force`。
2. `Update feeds` 步骤没有把 `./scripts/feeds` 的完整输出保存下来，所以日志里只有 `exit code 25`，看不到到底是哪个 feed 更新失败。

`Node.js 20 actions are deprecated` 只是 GitHub Actions 的弃用警告，不是这次失败的根因。

## 解决方案

### 已修复的内容

1. 移除了两个 workflow 中无效的 `force: true`
2. 为 `Checkout repository` 改成了合法参数 `fetch-depth: 1`
3. `Update feeds` 现在会生成 `openwrt/feeds.log`
4. `Upload build logs` 会上传 `feeds.log`、`download.log`、`build.log`
5. 日志 artifact 在前置步骤失败时不会再因为找不到文件而继续报噪音警告

---

### 重新运行建议

优先直接重新运行修正后的 workflow，先验证工作流配置已经正常。

**步骤**：

1. 在 GitHub 仓库中，点击 **Actions**
2. 选择 **"Build OpenWrt with iStoreOS"** 工作流
3. 点击 **Run workflow**
4. 在 **openwrt_branch** 输入框中输入：`main`
5. 点击 **Run workflow** 开始编译

**说明**：
- 先用 `main` 验证 workflow 本身是否恢复正常
- 如果你要指定 tag，再使用 upstream 已确认存在的 tag
- 这次如果 `feeds` 再失败，去下载 `build-logs` 里的 `feeds.log`，就能看到真正失败的 feed 和原始报错

---

### 如果你要指定版本标签

**步骤**：

1. 在 GitHub 仓库中，点击 **Actions**
2. 选择 **"Build OpenWrt with iStoreOS"** 工作流
3. 点击 **Run workflow**
4. 在 **openwrt_branch** 输入框中填写一个你已经在 upstream tags 页面确认存在的分支或标签
5. 点击 **Run workflow** 开始编译

**说明**：
- 不要把 workflow 失败和 tag 是否存在混为一谈
- 先修 workflow，再判断是不是具体 feed 或具体 tag 的兼容性问题

---

### 如何确认下一次失败的真正原因

1. 打开失败的 Actions 任务
2. 下载 `build-logs` artifact
3. 查看 `feeds.log`
4. 搜索 `error`、`fatal`、`No package`、`Collected errors`
5. 再决定是 feed 地址问题、上游仓库问题，还是包兼容性问题

---

## 已更新的工作流

我已经更新了工作流文件，修复了以下问题：

### 改进内容

1. ✅ 修复 `actions/checkout` 非法参数
2. ✅ 默认使用 `main` 分支
3. ✅ 添加错误处理（如果指定分支失败，自动尝试 main）
4. ✅ 使用浅克隆（`--depth 1`）加快下载
5. ✅ 为 `feeds`、`download`、`build` 单独保存日志
6. ✅ 改进日志上传

### 新的工作流参数

- **openwrt_branch**: OpenWrt 分支或标签
  - 默认值: `main`
  - 可选值: `main`，或 upstream 已确认存在的 tag / branch

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
   - **openwrt_branch**: `main` 或 upstream 已确认存在的 tag / branch
   - **enable_istoreos**: `true`
5. 点击 **Run workflow**

### 步骤 3：监控编译

1. 在 Actions 页面查看实时日志
2. 如果失败，先下载 `build-logs` 里的 `feeds.log`
3. 再根据 `feeds.log` 定位具体失败点

---

## 推荐配置

### 首次验证配置

- **openwrt_branch**: `main`
- **enable_istoreos**: `true`

### 最小排障配置

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

**A**: 先用 `main` 验证 workflow 是否正常，再根据 upstream 已存在的 tag 选择固定版本。

### Q: 如何知道编译成功了？

**A**: 查看 Actions 页面，如果显示绿色 ✅，表示编译成功。

### Q: 编译失败了怎么办？

**A**: 
1. 查看 Actions 日志
2. 下载 `build-logs` artifact
3. 先看 `feeds.log`
4. 再决定是切版本还是改 feed

### Q: 需要重新 Fork 吗？

**A**: 不需要，只需更新代码并重新运行编译。

---

## 下一步

1. ✅ 更新工作流文件
2. ✅ 推送代码到 GitHub
3. ✅ 重新运行编译
4. ✅ 如果失败先下载 `feeds.log`
5. ✅ 根据真实报错继续修

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

**修复完成。**

**推荐**: 先用 `main` 重新跑一次，确认 workflow 层面的错误已经消失。
