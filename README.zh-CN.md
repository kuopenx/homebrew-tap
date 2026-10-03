# Pagehub Homebrew tap

[English](README.md) · [简体中文](README.zh-CN.md)

在 macOS 上从带版本的源码安装 Pagehub。Homebrew 管理 Go 构建依赖，在本机编译 Pagehub；本 tap 不提供预编译 bottle。

```sh
brew install kuopenx/tap/pagehub
pagehub setup
pagehub connect codex    # 或：pagehub connect claude
pagehub doctor
pagehub open
```

升级：

```sh
brew upgrade pagehub
pagehub setup
pagehub doctor
```

其他源码安装方式、用法和安全边界见 [Pagehub 中文文档](https://github.com/kuopenx/pagehub/blob/main/README.zh-CN.md)。后台服务由 `pagehub setup` 安装，不使用 Homebrew services。Pagehub 支持 macOS 用户级 LaunchAgent 和 Linux 用户级 systemd 服务（需要 systemd 240+ 及活跃的用户管理器）。Linux 默认在登录时自启动；如需登录前启动，请显式启用 linger。Linux 源码安装方式见主仓库文档。

配方更新器每天检查最新公开的源码 Release。维护者也可手动运行 **Update Pagehub formula** 工作流，只使用本 tap 的 GitHub token，无需跨仓库机密。源码 SHA256 和标签提交号同时更新，不使用 Release 二进制或 Apple 签名。
