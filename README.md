# Pagehub Homebrew tap

[English](README.md) · [简体中文](README.zh-CN.md)

Install Pagehub on macOS from versioned source. Homebrew manages Go as a build dependency and compiles Pagehub locally; this tap provides no precompiled bottles.

```sh
brew install kuopenx/tap/pagehub
pagehub setup
pagehub connect codex    # or: pagehub connect claude
pagehub doctor
pagehub open
```

To upgrade:

```sh
brew upgrade pagehub
pagehub setup
pagehub doctor
```

See [Pagehub](https://github.com/kuopenx/pagehub) for other source installation methods, usage, and security boundaries. Background services are installed by `pagehub setup`, not by Homebrew services. Pagehub supports macOS user LaunchAgents and Linux user systemd services (systemd 240+ with an active user manager). Linux autostart is on login; enable linger explicitly if you need startup before login. See the main repository for Linux source installation.

The formula updater checks the latest published source Release daily. Maintainers can also run the **Update Pagehub formula** workflow manually. It uses only this tap's GitHub token; no cross-repository secret is needed. Source SHA256 and the tagged commit are updated together. Release binaries and Apple signing are not used.
