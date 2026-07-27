# Kora Releases

Public release channel for [Kora](https://kora-ai.download) — the AI assistant desktop app for macOS.

This repository hosts:

- **`latest.json`** — Tauri updater manifest (auto-update endpoint)
- **`macos-arm64/Install.command`** — Manual OTA install script
- **GitHub Releases** — Binary artifacts (`.dmg`, `.app.tar.gz`, `.sig`)

## Download

The latest release is always available on the [Releases page](https://github.com/andsigno82/kora-releases/releases).

## Manual OTA Install (ZIP)

1. Download `Kora.app.zip` from the [latest release](https://github.com/andsigno82/kora-releases/releases/latest)
2. Unzip and run `Install.command`

## Auto-Updater

Kora's built-in updater checks `latest.json` in this repository to detect new versions.

```
https://github.com/andsigno82/kora-releases/releases/latest/download/latest.json
```
