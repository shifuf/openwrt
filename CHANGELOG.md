# 更新日志

## v1.1.0 - 2024-XX-XX

### 新增
- ✅ 更新到 OpenWrt v25.12.2 (最新稳定版)
- ✅ 使用官方 PassWall 源 (Openwrt-Passwall)
- ✅ 添加 iStoreOS 支持
- ✅ 添加软件源配置文档 (SOURCES.md)
- ✅ 添加更新日志 (CHANGELOG.md)
- ✅ 添加配置检查脚本 (check-config.sh)

### 改进
- ✅ 优化工作流文件
- ✅ 更新软件源地址
- ✅ 改进错误处理
- ✅ 添加更多编译选项

### 修复
- ✅ 修复 PassWall 源地址问题
- ✅ 修复 iStoreOS 依赖问题
- ✅ 优化中文语言包处理

### 配置
- **OpenWrt 版本**: v25.12.2
- **PassWall 源**: https://github.com/Openwrt-Passwall/openwrt-passwall
- **iStoreOS 源**: https://github.com/kiddin9/openwrt-packages
- **软件包数量**: 126 个

## v1.0.0 - 2024-XX-XX

### 新增
- ✅ 初始版本
- ✅ 基础 OpenWrt 编译工作流
- ✅ iStoreOS 编译工作流
- ✅ 配置文件模板
- ✅ 完整的文档

### 功能
- 支持 JDCloud AX1800 Pro
- 支持 qualcommax/ipq60xx 平台
- 包含 PassWall 代理工具
- 包含 iStoreOS 应用商店
- 包含 123 个软件包

---

## 版本说明

### 版本号格式

采用语义化版本号：`主版本号.次版本号.修订号`

- **主版本号**: 重大更新或架构变更
- **次版本号**: 新功能或改进
- **修订号**: Bug 修复或小改进

### 更新频率

- **主版本**: 不定期
- **次版本**: 每月 1-2 次
- **修订号**: 根据需要

---

## 如何更新

### 更新到新版本

1. Fork 最新版本
2. 合并你的自定义配置
3. 重新编译

### 更新 OpenWrt 版本

修改工作流中的 `OPENWRT_VERSION`：

```yaml
env:
  OPENWRT_VERSION: 'v25.12.2'  # 修改为新版本
```

### 更新软件包

编辑 `config/qualcommax_ipq60xx.config`，添加或移除软件包。

---

## 计划中的功能

### v1.2.0 (计划中)
- [ ] 添加更多主题支持
- [ ] 优化编译速度
- [ ] 添加自动测试
- [ ] 支持更多设备

### v1.3.0 (计划中)
- [ ] 添加 Web UI 配置界面
- [ ] 支持在线更新
- [ ] 添加编译缓存
- [ ] 优化日志输出

---

## 贡献者

感谢所有贡献者的帮助！

- [你的名字] - 项目维护者

---

## 反馈

如有问题或建议，请提交 Issue 或 Pull Request。

---

## 许可证

本项目采用 MIT 许可证。

---

## 致谢

- [OpenWrt](https://openwrt.org/) - 开源路由器固件
- [PassWall](https://github.com/Openwrt-Passwall/openwrt-passwall) - 代理工具
- [iStoreOS](https://www.istoreos.com/) - 应用商店系统
- [kiddin9](https://github.com/kiddin9/openwrt-packages) - 软件源
