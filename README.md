# Zsh Configuration (.zshrc)

This repository contains my personal Zsh configuration file (`.zshrc`) optimized for Ubuntu systems. It includes modern shell features, aliases, functions, and an advanced system update function.

## Features

- **Modern Zsh Setup**: Optimized for Zsh 5.9+ with completion, history, and keybindings
- **Lean Aliases**: Useful shortcuts for common commands (ls, grep, etc.)
- **Advanced Update Function**: Comprehensive system updater with support for multiple package managers
- **Plugin Support**: Compatible with Oh My Zsh, zoxide, starship, and more
- **Cross-Platform**: Designed for Ubuntu but adaptable to other Linux distributions

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
