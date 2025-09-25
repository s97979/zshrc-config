# 🚀 zshrc-config ⚡

> 💡 A comprehensive, universal zsh configuration that works identically across Linux, WSL, MSYS2, Git-Bash, and Cygwin. Features a powerful `update()` function that manages 20+ package managers, smart aliases, modern tool integration, and optimized performance with compilation and caching.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20WSL%20%7C%20Windows%20%28MSYS2%20%7C%20Git--Bash%20%7C%20Cygwin%29-blue.svg)](https://github.com/bernardopg/zshrc-config)
[![GitHub issues](https://img.shields.io/github/issues/bernardopg/zshrc-config.svg)](https://github.com/bernardopg/zshrc-config/issues)
[![GitHub stars](https://img.shields.io/github/stars/bernardopg/zshrc-config.svg?style=social)](https://github.com/bernardopg/zshrc-config/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/bernardopg/zshrc-config.svg?style=social)](https://github.com/bernardopg/zshrc-config/network)
[![GitHub last commit](https://img.shields.io/github/last-commit/bernardopg/zshrc-config.svg)](https://github.com/bernardopg/zshrc-config/commits)
[![Repo size](https://img.shields.io/github/repo-size/bernardopg/zshrc-config.svg)](https://github.com/bernardopg/zshrc-config)
[![GitHub all releases](https://img.shields.io/github/downloads/bernardopg/zshrc-config/total.svg)](https://github.com/bernardopg/zshrc-config/releases)

## 📋 Navigation / Navegação 🚀

### 🌐 Languages / Idiomas 🌍

- **[English](#english)** - Complete documentation in English 🇺🇸
- **[Português (Brasil)](#português-brasil)** - Documentação completa em português 🇧🇷

### 📚 Documentation Sections / Seções da Documentação 📖

- **[Dotfiles — Universal Zsh + Update Function](#dotfiles--universal-zsh--update-function)** - Detailed technical documentation (English) ⚙️
- **[Dotfiles — Universal Zsh + Update Function](#dotfiles--universal-zsh--update-function-1)** - Documentação técnica detalhada (Português) ⚙️

### 📖 Other Documents / Outros Documentos 📋

- **[Contributing Guide / Guia de Contribuição](CONTRIBUTING.md)** - How to contribute to the project 🤝
- **[Security Policy / Política de Segurança](SECURITY.md)** - Security guidelines and vulnerability reporting 🔒
- **[License / Licença](LICENSE)** - MIT License details 📄

---

## English 🇺🇸

🚀 **zshrc-config** is a production-ready, universal zsh configuration designed for developers and system administrators. It provides a single `.zshrc` file that works identically across all major platforms, includes a comprehensive system update function, modern tool integrations, and performance optimizations.

This configuration is battle-tested and production-ready — use it as-is or customize to your needs.

### ✨ Features

- � **Universal compatibility**: Works on Linux, WSL, MSYS2, Git-Bash, Cygwin
- 🔄 **Comprehensive update system**: Manages 20+ package managers (apt, npm, cargo, pipx, etc.)
- 🚀 **Performance optimized**: zcompile, caching, lazy loading, XDG Base Directory compliance
- 🔒 **Security-first**: Private API keys outside repo, proper permissions
- 🎨 **Modern tool integration**: eza, bat, fzf, zoxide, starship auto-detection
- 📚 **Smart history**: Multi-terminal sync, no duplicates, monthly rotation (100k lines)
- 🎯 **Intelligent aliases**: Context-aware, fallback-enabled
- 🔌 **Oh My Zsh compatible**: Works with or without OMZ
- 🛠️ **Developer-friendly**: Git info, Docker/Podman setup, SSH agent management

### 🚀 Quick Installation

```bash
# 1. Clone the repository
git clone https://github.com/bernardopg/zshrc-config.git ~/.zshrc-config

# 2. Create symbolic link
ln -sf ~/.zshrc-config/.zshrc ~/.zshrc

# 3. Set up private directory for API keys
mkdir -p ~/.config/private
chmod 700 ~/.config/private
cp ~/.zshrc-config/env.example ~/.config/private/env.zsh
chmod 600 ~/.config/private/env.zsh

# 4. Reload zsh
exec zsh
```

✅ **Done!** The first load compiles the file for faster subsequent startups.

### Contributing

Pull requests are welcome. Open an issue to discuss larger changes first.

### Contact

- **Website**: [bebitterbebetter.com.br](https://bebitterbebetter.com.br/)
- **Email**: [bernardo.gomes@bebitterbebetter.com.br](mailto:bernardo.gomes@bebitterbebetter.com.br)
- **GitHub**: [@bernardopg](https://github.com/bernardopg)
- **Instagram**: [@be.pgomes](https://www.instagram.com/be.pgomes/)
- **ORCID**: [0009-0005-1610-5039](https://orcid.org/0009-0005-1610-5039)

### License

This project is licensed under the MIT License — see `LICENSE` for details.

---

## Dotfiles — Universal Zsh + Update Function

> A single `.zshrc` that works across multiple environments (Linux, WSL, MSYS2, Git-Bash), with fast completion, smart aliases, an `update()` function that integrates multiple package managers, and various performance improvements.

### ✨ Highlights

| Feature | Benefit |
|--------:|:--------|
| **Universal** | Identical on pure Linux, WSL, MSYS2, Cygwin, Git-Bash |
| **Secure** | API keys stay in `~/.config/private/env.zsh` (outside repo, `chmod 600`) |
| **Fast** | `zcompile`, lazy loading, `zsh-defer`, completion caching |
| **Complete** | `update` manages 20+ package managers with retry, logs, dry-run, cleanup |
| **Git-info** | Branch in prompt without slow plugins |
| **Multi-terminal history** | No duplicates, real-time, 100k lines |
| **True-color** | Activates only if terminal supports it |
| **No surprises** | Silences non-existent features (e.g., `beep`, `firmware` on WSL) |

### 📦 Quick Installation

```bash
# 1. Clone (or download just the .zshrc)
git clone https://github.com/bernardopg/zshrc-config.git ~/.zshrc-config

# 2. Create symbolic link
ln -sf ~/.zshrc-config/.zshrc ~/.zshrc

# 3. Create private directory (API keys, etc.)
mkdir -p ~/.config/private
chmod 700 ~/.config/private
cp ~/.zshrc-config/env.example ~/.config/private/env.zsh
chmod 600 ~/.config/private/env.zsh

# 4. Reload
exec zsh
```

Done! The first execution compiles the file (`zcompile`) and creates caches — subsequent shells open even faster.

### 🔑 Customizing API Keys

Edit `~/.config/private/env.zsh` (never committed):

```bash
export OPENAI_API_KEY='sk-XXXXXXXXXXXX'
export ANTHROPIC_API_KEY='sk-ant-XXXXXXXX'
```

Example available in `env.example`.

### ⚙️ Key Commands & Features

| Command | Description |
|:-------|:-----------|
| `update` or `up` | Updates **everything** (system, languages, containers, firmware) |
| `update --dry-run` | Simulates what would be updated (safe preview) |
| `update --system --cleanup` | Only system packages + cleanup old kernels |
| `update --only apt,npm,cargo` | Update specific package managers only |
| `update --exclude snap` | Update everything except specified managers |
| `update --security-only` | Security patches only |
| `update --low-data` | Skip bandwidth-heavy operations |
| `rz` | Reloads zsh after editing `.zshrc` |
| `zsh-health` | Quick diagnostic (cache size, PATH, history count) |
| `killport 3000` | Kills process on specified port (cross-platform) |
| `extract file.zip` | Extracts **any** compressed file format |
| `mkcd dirname` | Creates directory and cd into it |
| `ff pattern` | Fast file search by name pattern |
| `..` / `...` | Navigate up 1 or 2 directory levels |
| `ll` / `la` | Enhanced `ls` with eza/fallback, icons, and colors |

### 🔄 Update Function Features

**Supported Package Managers (20+):**

- **System**: apt, snap, flatpak, brew, nix, firmware (fwupdmgr)
- **Languages**: pip, pipx, npm, yarn, pnpm, cargo, rust, gem, composer, go, flutter
- **Dev Tools**: docker, podman, conda, mamba, asdf, sdkman, platformio
- **Shell**: oh-my-zsh, antigen, zinit

**Advanced Features:**

- 🔄 Exponential backoff retry with configurable attempts
- 🕐 APT lock detection with intelligent waiting
- 📊 Comprehensive logging with automatic rotation
- 🧹 Cleanup modes (caches, old kernels, unused packages)
- 🔒 Security-only updates support
- 🚦 Dry-run mode for safe testing
- 📡 Low-data mode for limited bandwidth
- ⚡ Parallel operations where safe
- 🛡️ WSL detection with platform-specific optimizations

### 🧩 Optional Dependencies (Auto-detected)

| Tool | Benefit | Auto-fallback |
|:----|:--------|:-------------|
| `eza` | Colored `ls` with icons | ✅ Falls back to `ls --color` |
| `bat`/`batcat` | `cat` with syntax highlighting | ✅ Falls back to `cat` |
| `fd`/`fdfind` | Fast `find` for FZF | ✅ Falls back to `find` |
| `zoxide` | `cd` with frecency | ✅ Falls back to `cd` |
| `starship` | Ultra-fast prompt | ✅ Falls back to custom git prompt |
| `fzf` | Fuzzy-find for history/files | ✅ Graceful degradation |
| `pipx` | Isolated Python apps (PEP 668) | ✅ Prevents system pip issues |

**🎯 Smart Detection**: All tools are auto-detected and gracefully fall back to standard alternatives.

### 🔄 Update Function Examples

```bash
# Safe preview of all updates
update --dry-run

# Security patches only
update --security-only

# System cleanup + kernel management
update --cleanup --kernels-keep 3

# Update specific managers only
update --only apt,npm,cargo

# Everything except problematic managers
update --exclude snap,flatpak

# Low bandwidth mode
update --low-data

# Non-interactive automation
update --yes --quiet

# Comprehensive update with cleanup
update --all --cleanup --security-only
```

**📊 Automatic Logging**: All operations logged to `~/.local/state/sysupdate/logs/` with rotation (keeps last 10 by default).

### 📁 Repository Structure

```text
.
├── .zshrc              # Main configuration (858 lines, feature-complete)
├── env.example         # Private environment template (API keys, etc.)
├── README.md           # This documentation
├── CONTRIBUTING.md     # Contribution guidelines
├── SECURITY.md         # Security policy
├── LICENSE             # MIT License
└── WARP.md            # Warp terminal integration notes
```

### 🏗️ Architecture Highlights

- **📁 XDG Base Directory Compliant**: All caches in `~/.cache/zsh/`, logs in `~/.local/state/`
- **🔒 Security-first**: Private keys in `~/.config/private/` (excluded from repo)
- **⚡ Performance**: zcompile, lazy loading, intelligent caching
- **🔄 Monthly History Rotation**: `history-2025-09` format prevents bloat
- **🌍 Platform Detection**: Auto-adapts to Linux/WSL/MSYS2/Git-Bash
- **🎨 True-color Detection**: Only enables advanced features when supported

### 🤝 Contributing

Contributions welcome! Please:

1. **Test on multiple platforms**: Linux, WSL, MSYS2, Git-Bash
2. **Follow the architecture**: XDG compliance, graceful fallbacks, performance-first
3. **Update documentation**: Keep README.md current with features
4. **Security-minded**: No API keys in repo, proper permissions

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

### 📄 License

MIT – do what you want, but no warranties.
See `LICENSE` for details.

---

## Português (Brasil) 🇧🇷

🚀 **zshrc-config** é uma configuração zsh universal e pronta para produção, projetada para desenvolvedores e administradores de sistema. Fornece um único arquivo `.zshrc` que funciona identicamente em todas as principais plataformas, inclui uma função abrangente de atualização do sistema, integrações com ferramentas modernas e otimizações de performance.

Esta configuração é testada em produção — use como está ou customize conforme suas necessidades.

### ✨ Funcionalidades

- � **Compatibilidade universal**: Funciona no Linux, WSL, MSYS2, Git-Bash, Cygwin
- 🔄 **Sistema de atualização abrangente**: Gerencia 20+ gerenciadores (apt, npm, cargo, pipx, etc.)
- 🚀 **Otimizado para performance**: zcompile, cache, carregamento lazy, compliance XDG
- � **Segurança em primeiro lugar**: Chaves API privadas fora do repo, permissões adequadas
- 🎨 **Integração com ferramentas modernas**: Auto-detecção de eza, bat, fzf, zoxide, starship
- � **Histórico inteligente**: Sync multi-terminal, sem duplicatas, rotação mensal (100k linhas)
- 🎯 **Aliases inteligentes**: Sensíveis ao contexto, com fallbacks
- 🔌 **Compatível com Oh My Zsh**: Funciona com ou sem OMZ
- 🛠️ **Amigável para desenvolvedores**: Info do Git, setup Docker/Podman, gerenciamento SSH agent

### 🚀 Instalação Rápida

```bash
# 1. Clone o repositório
git clone https://github.com/bernardopg/zshrc-config.git ~/.zshrc-config

# 2. Crie link simbólico
ln -sf ~/.zshrc-config/.zshrc ~/.zshrc

# 3. Configure diretório privado para chaves API
mkdir -p ~/.config/private
chmod 700 ~/.config/private
cp ~/.zshrc-config/env.example ~/.config/private/env.zsh
chmod 600 ~/.config/private/env.zsh

# 4. Recarregue o zsh
exec zsh
```

✅ **Pronto!** O primeiro carregamento compila o arquivo para startups mais rápidos posteriormente.

### Contribuindo

Pull requests são bem-vindos. Abra uma issue para discutir mudanças maiores antes.

### Contato

- **Site**: [bebitterbebetter.com.br](https://bebitterbebetter.com.br/)
- **Email**: [bernardo.gomes@bebitterbebetter.com.br](mailto:bernardo.gomes@bebitterbebetter.com.br)
- **GitHub**: [@bernardopg](https://github.com/bernardopg)
- **Instagram**: [@be.pgomes](https://www.instagram.com/be.pgomes/)
- **ORCID**: [0009-0005-1610-5039](https://orcid.org/0009-0005-1610-5039)

### Licença

Este projeto está licenciado sob a Licença MIT — veja `LICENSE` para detalhes.

---

## Dotfiles — Universal Zsh + Update Function

> Um único `.zshrc` que funciona em múltiplos ambientes (Linux, WSL, MSYS2, Git-Bash), com completion rápida, aliases inteligentes, função `update()` que integra vários gerenciadores e diversas melhorias de performance.

### ✨ Destaques

| Recurso | Benefício |
|--------:|:----------|
| **Universal** | Idêntico no Linux puro, WSL, MSYS2, Cygwin, Git-Bash |
| **Seguro** | Chaves de API ficam em `~/.config/private/env.zsh` (fora do repo, `chmod 600`) |
| **Rápido** | `zcompile`, carregamento lazy, `zsh-defer`, cache de completion |
| **Completo** | `update` gerencia 20+ gerenciadores com retry, logs, dry-run, cleanup |
| **Git-info** | Branch no prompt sem plugins lentos |
| **Histórico multi-terminal** | Sem duplicatas, tempo real, 100k linhas |
| **True-color** | Ativa só se o terminal suportar |
| **Sem surprises** | Silencia recursos inexistentes (ex.: `beep`, `firmware` no WSL) |

### 📦 Instalação rápida

```bash
# 1. Clone (ou baixe só o .zshrc)
git clone https://github.com/bernardopg/zshrc-config.git ~/.zshrc-config

# 2. Link simbólico
ln -sf ~/.zshrc-config/.zshrc ~/.zshrc

# 3. Crie o diretório privado (API keys, etc.)
mkdir -p ~/.config/private
chmod 700 ~/.config/private
cp ~/.zshrc-config/env.example ~/.config/private/env.zsh
chmod 600 ~/.config/private/env.zsh

# 4. Recarregue
exec zsh
```

Pronto! A primeira execução compila o arquivo (`zcompile`) e cria caches — próximos shells abrem ainda mais rápido.

### 🔑 Personalizando chaves de API

Edite `~/.config/private/env.zsh` (nunca commitado):

```bash
export OPENAI_API_KEY='sk-XXXXXXXXXXXX'
export ANTHROPIC_API_KEY='sk-ant-XXXXXXXX'
```

Exemplo disponível em `env.example`.

### ⚙️ Comandos e Recursos Principais

| Comando | Descrição |
|:-------|:----------|
| `update` ou `up` | Atualiza **tudo** (sistema, linguagens, containers, firmware) |
| `update --dry-run` | Simula o que seria atualizado (preview seguro) |
| `update --system --cleanup` | Só pacotes de sistema + limpa kernels antigos |
| `update --only apt,npm,cargo` | Atualiza gerenciadores específicos apenas |
| `update --exclude snap` | Atualiza tudo exceto gerenciadores especificados |
| `update --security-only` | Apenas patches de segurança |
| `update --low-data` | Pula operações que consomem muita banda |
| `rz` | Recarrega zsh após editar `.zshrc` |
| `zsh-health` | Diagnóstico rápido (tamanho cache, PATH, contagem histórico) |
| `killport 3000` | Mata processo na porta especificada (multiplataforma) |
| `extract arquivo.zip` | Extrai **qualquer** formato de arquivo compactado |
| `mkcd dirname` | Cria diretório e faz cd nele |
| `ff pattern` | Busca rápida de arquivos por padrão de nome |
| `..` / `...` | Navega 1 ou 2 níveis de diretório acima |
| `ll` / `la` | `ls` melhorado com eza/fallback, ícones e cores |

### 🔄 Recursos da Função Update

**Gerenciadores Suportados (20+):**

- **Sistema**: apt, snap, flatpak, brew, nix, firmware (fwupdmgr)
- **Linguagens**: pip, pipx, npm, yarn, pnpm, cargo, rust, gem, composer, go, flutter
- **Ferramentas Dev**: docker, podman, conda, mamba, asdf, sdkman, platformio
- **Shell**: oh-my-zsh, antigen, zinit

**Recursos Avançados:**

- 🔄 Retry com backoff exponencial e tentativas configuráveis
- 🕐 Detecção de locks do APT com espera inteligente
- 📊 Logging abrangente com rotação automática
- 🧹 Modos de limpeza (caches, kernels antigos, pacotes não utilizados)
- 🔒 Suporte a atualizações apenas de segurança
- 🚦 Modo dry-run para testes seguros
- 📡 Modo low-data para largura de banda limitada
- ⚡ Operações paralelas onde seguro
- 🛡️ Detecção WSL com otimizações específicas da plataforma

### 🧩 Dependências Opcionais (Auto-detectadas)

| Ferramenta | Benefício | Auto-fallback |
|:----------|:-----------|:-------------|
| `eza` | `ls` colorido com ícones | ✅ Volta para `ls --color` |
| `bat`/`batcat` | `cat` com syntax highlighting | ✅ Volta para `cat` |
| `fd`/`fdfind` | `find` rápido para FZF | ✅ Volta para `find` |
| `zoxide` | `cd` com frecência | ✅ Volta para `cd` |
| `starship` | Prompt ultra-rápido | ✅ Volta para prompt git customizado |
| `fzf` | Fuzzy-find para histórico/arquivos | ✅ Degradação graciosa |
| `pipx` | Apps Python isolados (PEP 668) | ✅ Previne problemas com pip do sistema |

**🎯 Detecção Inteligente**: Todas as ferramentas são auto-detectadas e voltam graciosamente para alternativas padrão.

### 🔄 Exemplos da Função Update

```bash
# Preview seguro de todas as atualizações
update --dry-run

# Apenas patches de segurança
update --security-only

# Limpeza do sistema + gerenciamento de kernel
update --cleanup --kernels-keep 3

# Atualizar apenas gerenciadores específicos
update --only apt,npm,cargo

# Tudo exceto gerenciadores problemáticos
update --exclude snap,flatpak

# Modo largura de banda baixa
update --low-data

# Automação não-interativa
update --yes --quiet

# Atualização abrangente com limpeza
update --all --cleanup --security-only
```

**📊 Logging Automático**: Todas as operações logadas em `~/.local/state/sysupdate/logs/` com rotação (mantém últimos 10 por padrão).

### 📁 Estrutura do Repositório

```text
.
├── .zshrc              # Configuração principal (858 linhas, completa)
├── env.example         # Template de ambiente privado (chaves API, etc.)
├── README.md           # Esta documentação
├── CONTRIBUTING.md     # Diretrizes de contribuição
├── SECURITY.md         # Política de segurança
├── LICENSE             # Licença MIT
└── WARP.md            # Notas de integração com terminal Warp
```

### 🏗️ Destaques da Arquitetura

- **📁 Compatível com XDG Base Directory**: Todos os caches em `~/.cache/zsh/`, logs em `~/.local/state/`
- **🔒 Segurança em primeiro lugar**: Chaves privadas em `~/.config/private/` (excluído do repo)
- **⚡ Performance**: zcompile, carregamento lazy, cache inteligente
- **🔄 Rotação Mensal do Histórico**: Formato `history-2025-09` previne inchaço
- **🌍 Detecção de Plataforma**: Auto-adapta para Linux/WSL/MSYS2/Git-Bash
- **🎨 Detecção True-color**: Apenas habilita recursos avançados quando suportado

### 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. **Teste em múltiplas plataformas**: Linux, WSL, MSYS2, Git-Bash
2. **Siga a arquitetura**: Compliance XDG, fallbacks graciosos, performance em primeiro lugar
3. **Atualize documentação**: Mantenha README.md atual com os recursos
4. **Pensamento em segurança**: Sem chaves API no repo, permissões adequadas

Veja [CONTRIBUTING.md](CONTRIBUTING.md) para diretrizes detalhadas.

### 📄 Licença

MIT – faça o que quiser, mas sem garantias.
Veja `LICENSE` para detalhes.
