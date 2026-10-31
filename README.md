# Kora

**Your models. Your workspace.** Kora brings chat, editor, Git, terminal, and tools together in one place, with the AI models you choose. Free, no account required.

**Website: [kora-ai.download](https://kora-ai.download)** · [Documentation](https://docs.kora-ai.download/) · [What's new](https://docs.kora-ai.download/updates/whats-new/) · [Pricing](https://kora-ai.download/en/pricing)

---

## Kora Desktop

The desktop workspace for macOS: multi-model chat, a code editor with diff review, Git, an integrated terminal, tools, skills, remote SSH projects, and optional encrypted Cloud Sync.

→ **[kora-ai.download](https://kora-ai.download)**

```bash
# curl
curl -fsSL https://kora-ai.download/release/kora/install.sh | sh

# Bun
bunx @kora-ai/desktop

# npm
npx @kora-ai/desktop
```

The installer downloads the latest release, verifies it, and installs it in `/Applications`. Prefer a manual download? Get it from [kora-ai.download/release/latest](https://kora-ai.download/release/latest).

Requirements: macOS 11 or later, Apple Silicon.

## Kora CLI

Your Kora sessions in the terminal. Same sessions, providers, and tools as Kora Desktop, with a shared workspace. Also available as a [VS Code extension](https://marketplace.visualstudio.com/items?itemName=deploystudio.kora).

→ **[kora-ai.download/en/cli](https://kora-ai.download/en/cli)**

```bash
# curl
curl -fsSL https://kora-ai.download/release/cli/install.sh | sh

# Bun
bun install -g @kora-ai/cli

# npm
npm install -g @kora-ai/cli
```

Requirements: macOS (Apple Silicon) or Linux (x64, arm64). Self-contained binary, no Node.js required at runtime.

## Updates

Both apps update themselves: Kora Desktop through its built-in updater, Kora CLI in the background (restart to apply). See [Update Kora](https://docs.kora-ai.download/guides/updates/).

Release history: [CHANGELOG.md](CHANGELOG.md).

---

## About this repository

This is Kora's public release channel. It contains no source code. It hosts:

- **[CHANGELOG.md](CHANGELOG.md)**: the public changelog, updated with every release
- **[Releases](https://github.com/andsigno82/kora-releases/releases)**: Kora Desktop ZIP packages and Kora CLI binaries, used by the built-in updaters
- **`macos-arm64/Install.command`**: the installer shipped inside the Kora Desktop ZIP
- **`latest.json`**: the updater manifest

See [Releases and downloads](https://docs.kora-ai.download/guides/releases/) for how the channel is organized.
