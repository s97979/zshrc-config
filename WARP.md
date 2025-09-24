# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is `zshrc-config` - a universal zsh configuration that works across multiple environments (Linux, WSL, MSYS2, Git-Bash, Cygwin). It provides a single `.zshrc` file with fast completion, smart aliases, an `update()` function that integrates multiple package managers, and various performance improvements.

**Key Features:**
- Universal compatibility across platforms
- Secure API key management via `~/.config/private/env.zsh`
- Performance optimizations (zcompile, lazy loading, completion caching)
- Comprehensive `update` function for 20+ package managers
- Git branch info in prompt without slow plugins
- Multi-terminal history synchronization

## Repository Structure

```
.
├── .zshrc              # Main configuration file (universal)
├── env.example         # Template for private API keys/env vars
├── README.md           # Comprehensive documentation (bilingual)
├── CONTRIBUTING.md     # Development guidelines (bilingual)
├── LICENSE             # MIT license
├── SECURITY.md         # Security policy
└── .gitignore          # Excludes secrets, backups, compiled files
```

## Quick Commands

| Command | Purpose |
|---------|---------|
| `zsh -n .zshrc` | Syntax check the main config file |
| `ln -sf $(pwd)/.zshrc ~/.zshrc` | Install config via symlink |
| `exec zsh` | Reload zsh after config changes |
| `rz` | Reload zsh (alias built into config) |
| `zsh-health` | Check cache size, tools, PATH, history |
| `update --dry-run` | Preview what would be updated |
| `update --help` | Show all update function options |

## Installation and Setup

### Prerequisites
- Zsh 5.0+ installed
- Git for cloning repository
- Optional: modern tools like `eza`, `bat`, `fd`, `zoxide`, `starship`, `fzf`

### Installation Steps

1. **Clone and install:**
```bash
git clone https://github.com/bernardopg/zshrc-config.git ~/.zshrc-config
ln -sf ~/.zshrc-config/.zshrc ~/.zshrc
```

2. **Set up private environment (API keys, etc.):**
```bash
mkdir -p ~/.config/private
chmod 700 ~/.config/private
cp ~/.zshrc-config/env.example ~/.config/private/env.zsh
chmod 600 ~/.config/private/env.zsh
# Edit ~/.config/private/env.zsh with your API keys
```

3. **Reload shell:**
```bash
exec zsh
```

### Verification
```bash
echo $ZSH_VERSION  # Confirm zsh is active
zsh-health         # Check installation health
```

## Configuration Architecture

### Core Components

- **XDG Base Directory Support**: Uses `$XDG_CONFIG_HOME`, `$XDG_CACHE_HOME`, `$XDG_STATE_HOME`
- **History Management**: 100k lines, shared across terminals, deduplication
- **PATH Construction**: Intelligent, deduplicated, platform-aware
- **Completion System**: Falls back to manual setup if Oh-My-Zsh not available
- **Modern Tool Integration**: Auto-detects and configures `zoxide`, `starship`, `bat`, `fd`, etc.

### Platform Detection

The config detects and adapts to:
- **WSL**: Via `/proc/version` check
- **Windows environments**: MSYS2, Git-Bash, Cygwin paths
- **macOS**: Homebrew paths and tools
- **Linux**: Standard system paths and package managers

### Security Model

- **Private configuration**: API keys stored in `~/.config/private/env.zsh` (outside repo)
- **File permissions**: Private config has `600` permissions
- **No secrets in repo**: `.gitignore` excludes all sensitive files
- **SSH agent**: Auto-starts with 12-hour timeout
- **GPG integration**: Sets `GPG_TTY` appropriately

## Update Function Architecture

**Note**: The main `.zshrc` file has a placeholder for the update function at line 243. The actual implementation appears to be missing or provided separately.

The update function is designed to:
- Support 20+ package managers (apt, brew, npm, cargo, etc.)
- Provide dry-run capability
- Include retry logic and logging
- Support selective updates (`--only`, `--exclude`)
- Clean up old packages and caches
- Work across all supported platforms

### Common Usage Patterns
```bash
update                    # Update everything
update --dry-run          # Preview changes
update --system --cleanup # System packages + cleanup
update --only npm,cargo   # Specific package managers
update --security-only    # Critical patches only
```

## Development Workflow

### Testing Changes

1. **Syntax check:**
```bash
zsh -n .zshrc
```

2. **Test in clean environment:**
```bash
env -i HOME=$HOME zsh -l
```

3. **Performance test:**
```bash
time zsh -i -c exit
```

### Making Changes

- Edit `.zshrc` directly
- Test changes with `zsh -n .zshrc`
- Reload with `exec zsh` or `rz`
- For permanent changes, commit to git

### Cross-Platform Testing

Test on:
- Pure Linux (Ubuntu, Fedora)
- WSL (Windows Subsystem for Linux)
- macOS with Homebrew
- Windows Git-Bash/MSYS2

## Security Guidelines

### Do's
- Keep API keys in `~/.config/private/env.zsh`
- Use `chmod 600` for private configuration
- Review update diffs before applying
- Test configuration changes in clean environments

### Don'ts
- Never commit backup files (they may contain sensitive information)
- Don't source untrusted remote scripts
- Avoid running updates as root
- Don't include secrets directly in `.zshrc`

## Key Aliases and Functions

### Built-in Aliases
- `ll`/`la`: Enhanced `ls` (uses `eza` if available)
- `..`/`...`: Navigate up directories
- `rz`: Reload zsh configuration
- `gh`: Grep history
- `ports`: List listening ports
- `serve`: Start HTTP server on port 8080

### Built-in Functions
- `extract <file>`: Extract any archive format
- `killport <port>`: Kill process on specified port
- `mkcd <dir>`: Create and enter directory
- `ff <pattern>`: Find files by pattern
- `zsh-health`: System health check

## Troubleshooting

### Common Issues

1. **Slow startup**: Check `zsh-health`, disable unneeded plugins
2. **Completion issues**: Run `rm -rf ${XDG_CACHE_HOME:-~/.cache}/zsh/zcompcache`
3. **History problems**: Check `$HISTFILE` permissions and disk space
4. **PATH issues**: Use `path` alias to inspect, check for duplicates

### Diagnostic Commands
```bash
zsh-health           # Overall health check
echo $fpath          # Check function path
typeset -f <name>    # Inspect function definition
which -a <command>   # Show all versions of command
```

## Contributing Guidelines

### Code Style
- Use clear, descriptive function names
- Include usage comments for complex functions
- Test across multiple platforms
- Follow existing indentation and style

### Commit Style
- Use conventional commits (`feat:`, `fix:`, `docs:`, etc.)
- Reference issues when applicable
- Keep commits focused and atomic

### Testing Requirements
- Syntax check with `zsh -n`
- Test on Linux, macOS, and WSL
- Verify startup performance impact
- Check for security implications

**Important**: Never commit backup files as they may contain sensitive information. The `.gitignore` is configured to exclude common backup patterns.

## Maintenance

### Regular Tasks
- Update optional tool integrations when new versions release
- Test configuration with latest zsh versions
- Review and update platform-specific paths
- Keep documentation synchronized with code changes

### When Adding Features
- Update this WARP.md file
- Add appropriate aliases/functions to main table
- Test cross-platform compatibility
- Update `.gitignore` if needed for new file types