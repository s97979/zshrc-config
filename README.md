# 🚀 zshrc-config ⚡

> 💡 A minimal, portable zsh configuration and helper collection. Includes aliases, functions and an `update()` helper that can manage system and language package managers across Linux, WSL and Windows environments.

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

🚀 **zshrc-config** is a small collection of configuration snippets and helpers for zsh (`.zshrc`) tailored for personal use. It contains aliases, functions and recommended plugins to speed up shell productivity.

This repository is intentionally minimal — use it as a starting point or copy snippets into your own `~/.zshrc`.

### ✨ Features

- 🏷️ Simple aliases for common tasks
- 🔧 Useful zsh functions and helpers
- 📦 Plugin recommendations and notes

### 🚀 Quick start

1. Clone the repo:

```bash
git clone https://github.com/bernardopg/zshrc-config.git
```

2. Inspect and copy the parts you want into your `~/.zshrc` or source files:

```bash
cp ~/.zshrc-config/some-snippet.zsh ~/.zshrc.d/
```

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

### ⚙️ Main Commands

| Command | Description |
|:-------|:-----------|
| `update` or `up` | Updates **everything** (system, languages, containers, firmware) |
| `update --dry-run` | Simulates what would be updated |
| `update --system --cleanup` | Only system packages + cleanup |
| `update --only apt,npm` | Choose specific package managers |
| `rz` | Reloads zsh after editing `.zshrc` |
| `zsh-health` | Mini-diagnostic (cache, PATH, history) |
| `killport 3000` | Kills process on port 3000 (Linux/Windows) |
| `extract file.zip` | Extracts **any** compressed file |
| `..` / `...` | Go up 1 or 2 levels |
| `ll` / `la` | Enhanced `ls` (uses `eza` if available) |

### 🧩 Optional Dependencies (but recommended)

| Tool | Benefit |
|:----|:--------|
| `eza` | Colored `ls` with icons |
| `bat` | `cat` with syntax highlighting |
| `fd` | Fast `find` for FZF |
| `zoxide` | `cd` with "frequency" |
| `starship` | Ultra-fast prompt (replaces default) |
| `fzf` | Fuzzy-find for history/files |
| `pipx` | Isolated Python applications (PEP 668) |

Install via `update --only <manager>` or native package manager.

### 🔄 Update Function – Examples

```bash
update --dry-run                  # preview
update --security-only            # only critical patches
update --cleanup --kernels-keep 3 # clean old kernels
update --exclude snap             # everything except snap
```

Logs are stored in `~/.local/state/sysupdate/logs/` with automatic rotation.

### 📁 Repository Structure

```text
.
├── .zshrc              # Main file (only one you need)
├── env.example         # API keys template
├── LICENSE             # MIT
└── README.md           # This file
```

### 🤝 Contributing

Suggestions and PRs are welcome! Test on **pure Linux**, **WSL**, and **Windows (Git-Bash/MSYS2)** before opening a PR.

### 📄 License

MIT – do what you want, but no warranties.
See `LICENSE` for details.

---

## Português (Brasil) 🇧🇷

🚀 **zshrc-config** é uma pequena coleção de trechos de configuração e utilitários para zsh (`.zshrc`) adaptada para uso pessoal. Contém aliases, funções e recomendações de plugins para aumentar a produtividade no shell.

Este repositório é propositalmente minimalista — use como ponto de partida ou copie trechos para o seu `~/.zshrc`.

### ✨ Funcionalidades

- 🏷️ Aliases simples para tarefas comuns
- 🔧 Funções e helpers úteis para zsh
- 📦 Recomendações e notas sobre plugins

### 🚀 Começando rapidamente

1. Clone o repositório:

```bash
git clone https://github.com/bernardopg/zshrc-config.git
```

2. Inspecione e copie as partes que desejar para o seu `~/.zshrc` ou arquivos de sourced:

```bash
cp zshrc-config/some-snippet.zsh ~/.zshrc.d/
```

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

### ⚙️ Comandos principais

| Comando | Descrição |
|:-------|:----------|
| `update` ou `up` | Atualiza **tudo** (sistema, linguagens, containers, firmware) |
| `update --dry-run` | Simula o que seria atualizado |
| `update --system --cleanup` | Só pacotes de sistema + limpeza |
| `update --only apt,npm` | Escolhe gerenciadores |
| `rz` | Recarrega o zsh após editar `.zshrc` |
| `zsh-health` | Mini-diagnóstico (cache, PATH, histórico) |
| `killport 3000` | Mata processo na porta 3000 (Linux/Windows) |
| `extract arquivo.zip` | Extrai **qualquer** compactado |
| `..` / `...` | Up 1 ou 2 níveis |
| `ll` / `la` | `ls` melhorado (usa `eza` se disponível) |

### 🧩 Dependências opcionais (mas recomendadas)

| Ferramenta | Ganho |
|:----------|:------|
| `eza` | `ls` colorido e com ícones |
| `bat` | `cat` com syntax-highlight |
| `fd` | `find` rápido para FZF |
| `zoxide` | `cd` com "frecência" |
| `starship` | Prompt ultra-rápido (substitui o default) |
| `fzf` | Fuzzy-find para histórico/arquivos |
| `pipx` | Aplicativos Python isolados (PEP 668) |

Instale via `update --only <manager>` ou gerenciador nativo.

### 🔄 Função `update` – exemplos

```bash
update --dry-run                  # preview
update --security-only            # só patches críticos
update --cleanup --kernels-keep 3 # limpa kernels antigos
update --exclude snap             # tudo, menos snap
```

Logs ficam em `~/.local/state/sysupdate/logs/` com rotação automática.

### 📁 Estrutura do repo

```text
.
├── .zshrc              # Arquivo principal (único que você precisa)
├── env.example         # Template de chaves/APIs
├── LICENSE             # MIT
└── README.md           # Este arquivo
```

### 🤝 Contribuindo

Sugestões e PRs são bem-vindos! Teste no **Linux puro**, **WSL** e **Windows (Git-Bash/MSYS2)** antes de abrir PR.

### 📄 Licença

MIT – faça o que quiser, mas sem garantias.
Veja `LICENSE` para detalhes.
