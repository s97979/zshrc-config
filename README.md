
# 🚀 Ultimate Zsh Configuration for Power Users

> **A modern, minimal, and powerful `.zshrc` for Linux users who want speed, productivity, and style.**

Welcome to the ultimate Zsh configuration! This repo brings you a battle-tested, feature-rich `.zshrc` designed for Ubuntu and adaptable to any Linux distribution. Enjoy blazing-fast completions, beautiful prompts, smart aliases, and a next-level system update function—all in a single file.

---

## ✨ Highlights

- **Lightning-Fast Completions**: Optimized for Zsh 5.9+ with robust tab completion and history search.
- **Smart Aliases & Functions**: Save keystrokes with enhanced `ls`, `grep`, `mkcd`, `extract`, and more.
- **One-Command System Update**: The `update` function upgrades your system, dev tools, and language packages—intelligently and safely.
- **Plugin-Ready**: Works out-of-the-box with Oh My Zsh, zoxide, starship, eza, bat, fd, and more.
- **Persistent, Clean History**: Never lose your command history, with deduplication and XDG support.
- **Beautiful Prompt**: Customizable, minimal, and compatible with Starship.
- **Cross-Platform**: Built for Ubuntu, but easily portable to other distros.

---

## 🚦 Quick Start

```bash
git clone https://github.com/bernardopg/zshrc-config.git
cp zshrc-config/.zshrc ~/.zshrc
source ~/.zshrc
```

---

## 🛠️ Features in Detail

- **System Update Function**: Run `update` for a full system upgrade (APT, Snap, Flatpak, dev tools, language managers, and more). Includes advanced options, logging, and error handling.
- **Modern Aliases**: Enhanced `ls`, `ll`, `la`, `grep`, and utilities for daily productivity.
- **Handy Functions**: `mkcd`, `extract`, `killport`, `bk`, `ff`, and more.
- **Plugin Support**: Seamless integration with Oh My Zsh, zoxide, starship, eza, bat, fd, and others.
- **Persistent History**: XDG-compliant, deduplicated, and shared across sessions.
- **Minimal, Fast, and Clean**: No bloat, no unnecessary plugins—just what you need.

---

## 📦 Requirements

- Zsh 5.9+
- Ubuntu (or compatible Linux)
- Optional: [Oh My Zsh](https://ohmyz.sh/), [zoxide](https://github.com/ajeetdsouza/zoxide), [starship](https://starship.rs/), [eza](https://eza.rocks/), [bat](https://github.com/sharkdp/bat), [fd](https://github.com/sharkdp/fd)

---

## 💡 Usage Examples

- `update` — Run a full system update (see `update --help` for options)
- `ls`, `ll`, `la` — Enhanced directory listings
- `mkcd <dir>` — Create and enter a directory
- `extract <file>` — Extract any archive format
- `killport <port>` — Kill process on a given port
- `bk <file>` — Quick file backup
- `ff <pattern>` — Find files by pattern

---

## 🤝 Contributing

Fork, adapt, and send your pull requests! Suggestions and improvements are always welcome.

---

## 📜 License

MIT License. Use, modify, and share freely.

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/bernardopg/zshrc-config.git
   ```

2. Copy the `.zshrc` to your home directory:

   ```bash
   cp zshrc-config/.zshrc ~/.zshrc
   ```

3. Reload your Zsh configuration:

   ```bash
   source ~/.zshrc
   ```

## Key Components

- **System Update Function**: Run `update` for comprehensive system updates
- **Modern Aliases**: Enhanced ls, grep, and utility commands
- **History Management**: Persistent history with deduplication
- **Completion**: Fast and robust tab completion
- **Path Management**: Automatic path setup for local binaries

## Requirements

- Zsh 5.9+
- Ubuntu (or compatible Linux distribution)
- Optional: Oh My Zsh, zoxide, starship, eza, bat, fd

## Usage

After installation, you can use various aliases and functions:

- `update`: Run system updates
- `ls` / `ll` / `la`: Enhanced directory listing
- `grep`: Colored grep output
- `mkcd <dir>`: Create and cd into directory
- `extract <file>`: Extract various archive formats

## Contributing

Feel free to fork and adapt this configuration to your needs. Pull requests are welcome!

## License

This configuration is provided as-is for personal use. Modify and distribute freely.
