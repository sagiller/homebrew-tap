# DataCode Homebrew Tap

本仓库提供 DataCode CLI 的 Homebrew Formula，支持 Apple Silicon、Intel Mac、Linux arm64 和 Linux x64。

## 安装

```bash
brew install sagiller/tap/datacode
```

验证：

```bash
datacode --version
```

## 升级与卸载

```bash
brew upgrade datacode
brew uninstall datacode
```

Homebrew 安装的 DataCode 必须由 Homebrew 升级。`datacode upgrade` 不会改写 Homebrew 管理的文件。

## 完整性

Formula 的版本、下载地址和 SHA-256 由 [DataCode Runtime Releases](https://github.com/sagiller/datacode-releases/releases) 的 `datacode-manifest.json` 生成。Runtime 目前未进行 Apple 公证或代码签名。
