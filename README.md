# Kora Releases

Public release channel for [Kora](https://kora-ai.download) — the AI assistant desktop app for macOS.

## What's new

- **Queue automation** — advance queued messages automatically after each completed turn
- **Open response canvas** — show model answers on an open canvas for a cleaner reading experience
- **Cleaner user prompts** — redesign the prompt with a clearer full-width layout and a single timestamp in the footer
- **Compact inline file references** — render file paths as compact chips inside chat messages
- **Automatic context optimization** — adapt optimization to the active model and conversation size

Full history in [CHANGELOG.md](CHANGELOG.md).

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
