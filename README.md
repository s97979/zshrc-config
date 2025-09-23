
# zshrc-config

> A minimal, portable zsh configuration and helper collection. Includes aliases, functions and an `update()` helper that can manage system and language package managers across Linux, WSL and Windows environments.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20WSL%20%7C%20Windows%20%28MSYS2%20%7C%20Git--Bash%20%7C%20Cygwin%29-blue.svg)](https://github.com/bernardopg/zshrc-config)

## English

zshrc-config is a small collection of configuration snippets and helpers for zsh (`.zshrc`) tailored for personal use. It contains aliases, functions and recommended plugins to speed up shell productivity.

This repository is intentionally minimal — use it as a starting point or copy snippets into your own `~/.zshrc`.

### Features

- Simple aliases for common tasks
- Useful zsh functions and helpers
- Plugin recommendations and notes

### Quick start

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

## Português (Brasil)

zshrc-config é uma pequena coleção de trechos de configuração e utilitários para zsh (`.zshrc`) adaptada para uso pessoal. Contém aliases, funções e recomendações de plugins para aumentar a produtividade no shell.

Este repositório é propositalmente minimalista — use como ponto de partida ou copie trechos para o seu `~/.zshrc`.

### Funcionalidades

- Aliases simples para tarefas comuns
- Funções e helpers úteis para zsh
- Recomendações e notas sobre plugins

### Começando rapidamente

1. Clone o repositório:

```bash
git clone https://github.com/bernardopg/zshrc-config.git
```

2. Inspecione e copie as partes que desejar para o seu `~/.zshrc` ou arquivos de sourced:

```bash
cp ~/.zshrc-config/some-snippet.zsh ~/.zshrc.d/
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
├── LICENSE          # MIT
└── README.md           # Este arquivo
```

### 🤝 Contribuindo

Sugestões e PRs são bem-vindos! Teste no **Linux puro**, **WSL** e **Windows (Git-Bash/MSYS2)** antes de abrir PR.

### 📄 Licença

MIT – faça o que quiser, mas sem garantias.

## Português (Brasil)

zshrc-config é uma pequena coleção de trechos de configuração e utilitários para zsh (`.zshrc`) adaptada para uso pessoal. Contém aliases, funções e recomendações de plugins para aumentar a produtividade no shell.

Este repositório é propositalmente minimalista — use como ponto de partida ou copie trechos para o seu `~/.zshrc`.

### Funcionalidades

- Aliases simples para tarefas comuns
- Funções e helpers úteis para zsh
- Recomendações e notas sobre plugins

### Começando rapidamente

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

# Replace clone URL to the actual repo
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
| `zoxide` | `cd` com “frecência” |
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
├── LICENSE          # MIT
└── README.md           # Este arquivo
```

### 🤝 Contribuindo

Sugestões e PRs são bem-vindos! Teste no **Linux puro**, **WSL** e **Windows (Git-Bash/MSYS2)** antes de abrir PR.

### 📄 Licença

MIT – faça o que quiser, mas sem garantias.
