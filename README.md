# JDCloud AX1800 Pro Kwrt Builder

这个仓库现在只保留一条构建路线：**按 `Kwrt` 的设备流程构建 JDCloud AX1800 Pro 固件**。

当前做法是：

- 构建入口：`https://github.com/kiddin9/Kwrt`
- 上游源码：`https://github.com/openwrt/openwrt`
- Kwrt 公共包源：`https://github.com/kiddin9/op-packages`
- 额外保留的包源：
  - `https://github.com/Openwrt-Passwall/openwrt-passwall`
  - `https://github.com/Openwrt-Passwall/openwrt-passwall-packages`

额外保留 `PassWall` feed 的原因很直接：你当前这份 `config/qualcommax_ipq60xx.config` 已经明确启用了 `luci-app-passwall` 和一组相关组件，所以 workflow 会在 `Kwrt` 设备栈准备完成后再补这两个 feed，保证 `defconfig` 不掉包。

## 仓库结构

- `.github/workflows/build-openwrt.yml`
  唯一保留的 GitHub Actions 工作流，名称是 `Build Kwrt for JDCloud AX1800 Pro`。
- `config/qualcommax_ipq60xx.config`
  你的本地包配置，目标平台是 `qualcommax/ipq60xx`，设备 profile 是 `jdcloud_re-ss-01`。
- `scripts/prepare-kwrt.sh`
  把 `Kwrt` 的 common/device `diy.sh`、补丁和自定义 feed 准备逻辑收敛成一个脚本。
- `scripts/check-config.sh`
  检查当前配置里关键包是否启用。
- `scripts/modify-config.sh`
  本地增删包的辅助脚本。

## 工作流行为

`Build Kwrt for JDCloud AX1800 Pro` 会按下面的顺序执行：

1. 拉取 `Kwrt` 指定分支，默认 `25.12`。
2. 拉取 `OpenWrt` 指定分支，默认 `openwrt-25.12`。
3. 将 `Kwrt` 的 `devices/common` 和 `devices/qualcommax_ipq60xx` 注入到源码树。
4. 执行 `Kwrt` 的 common/device `diy.sh` 和设备补丁。
5. 追加 `PassWall` feeds。
6. 载入本仓库的 `config/qualcommax_ipq60xx.config`。
7. `make defconfig`、`make download`、`make`.

## 如何构建

1. Fork 这个仓库。
2. 打开 GitHub `Actions`。
3. 运行 `Build Kwrt for JDCloud AX1800 Pro`。
4. 默认建议参数：
   - `kwrt_branch`: `25.12`
   - `openwrt_branch`: `openwrt-25.12`

如果你后面要手动改成别的 `OpenWrt` tag 或分支，也可以覆盖这个输入；但当前这套 `Kwrt 25.12` 设备补丁是按 `openwrt-25.12` 基线更稳。

## 构建产物和日志

- 固件产物会出现在 `Artifacts` 里的 `kwrt-jdcloud-ax1800-pro`。
- 日志会出现在 `Artifacts` 里的 `build-logs`。
- 日志包含：
  - `feeds.log`
  - `download.log`
  - `build.log`

排障优先看 `feeds.log`，其次是 `build.log`。

## 如何改包

直接编辑 `config/qualcommax_ipq60xx.config`，或者用脚本：

```bash
./scripts/modify-config.sh -a luci-app-openclash
./scripts/modify-config.sh -r luci-app-openclash
./scripts/modify-config.sh -l
```

配置文件里推荐用标准的 OpenWrt 写法：

```text
CONFIG_PACKAGE_foo=y
# CONFIG_PACKAGE_bar is not set
```

## 默认信息

这个仓库的本地准备脚本会在 `Kwrt` common/device `diy.sh` 执行完成后，强制把默认后台地址改回 `192.168.1.1`。

- 默认地址：`192.168.1.1`
- 用户名：`root`
- 默认密码：空，首次登录自行设置
- 刷机方式：按你的 U-Boot 流程刷入生成的 `.bin`
