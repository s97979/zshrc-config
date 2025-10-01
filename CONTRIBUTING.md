# Contributing to zshrc-config

Thanks for your interest in contributing! This document is a short,
actionable guide to help you report issues, propose changes, and submit pull
requests.

Please read our [Code of Conduct](CODE_OF_CONDUCT.md) before contributing.

---

## Quick checklist (before opening an issue or PR)

- Search existing issues to avoid duplicates
- Follow the Code of Conduct
- Provide clear descriptions, steps to reproduce, and expected vs actual
  behavior
- Add tests or reproduction steps when possible
- Use a topic branch for changes (feature/ or fix/)

---

## Reporting bugs

When filing a bug report, include:

- A clear title and short summary
- Environment: OS, Zsh version (`zsh --version`), terminal emulator
- Steps to reproduce
- Relevant snippets of your `.zshrc` or other config
- Expected vs actual behavior
- Screenshots or logs (if helpful)

Use the "Bug" issue template when available.

---

## Suggesting features

When proposing a new feature:

- Explain the problem and the user benefit
- Provide examples or a short design sketch
- Note any cross-platform considerations
- Optionally open an RFC or discussion first for larger changes

---

## Code contributions (PR process)

1. Fork the repo and create a branch:

```bash
git clone https://github.com/bernardopg/zshrc-config.git
cd zshrc-config
git checkout -b feature/your-feature-name
```

2. Make small, focused commits. Follow the commit message format below.
3. Run local checks and tests (see Testing section).
4. Push your branch and open a PR against `main` with a clear title and
   description. Reference related issues (e.g. "Fixes #123").

PR checklist (maintainers may require these):

- [ ] CI passes (if any)
- [ ] Tests or manual verification steps included
- [ ] Documentation updated (README or relevant docs)
- [ ] Linked issue or clear motivation

---

## Commit message format

Use this lightweight format:

```text
type(scope): short description

Longer description if needed.

Closes #123
```

Common types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`,
`chore`.

---

## Testing locally

This project relies on Zsh configurations; tests are primarily manual.

Commands to help test changes locally:

```bash
# Create a backup of your current zshrc
cp ~/.zshrc ~/.zshrc.backup

# Link this repo's .zshrc for testing
ln -sf "$(pwd)/.zshrc" ~/.zshrc

# Start a fresh interactive shell to exercise startup
zsh -i

# Quick syntax check
zsh -n .zshrc

# Measure startup time
time zsh -i -c exit
```

Tip: Test on multiple environments (Linux, macOS, WSL) when relevant.

---

## Style & quality

- Prefer simple, portable shell code
- Avoid slow startup operations
- Document functions with a brief header (description, args, example)
- Never commit secrets or credentials

---

## Getting help

- For questions, open an issue or discussion
- For sensitive reports, see the private contact in `CODE_OF_CONDUCT.md`

---

## Português (Brasil)

Obrigado pelo interesse em contribuir! Abaixo um guia curto e prático para
reportar issues, propor mudanças e enviar pull requests.

Leia nosso [Código de Conduta](CODE_OF_CONDUCT.md) antes de contribuir.

---

## Checklist rápido (antes de abrir issue/PR)

- Busque por issues existentes para evitar duplicatas
- Siga o Código de Conduta
- Forneça descrições claras, passos para reproduzir e comportamento esperado
  vs observado
- Adicione testes ou passos de reprodução quando possível
- Use uma branch por tópico (feature/ ou fix/)

---

## Relatando bugs

Ao abrir um relatório de bug inclua:

- Título claro e resumo
- Ambiente: SO, versão do Zsh (`zsh --version`), emulador de terminal
- Passos para reproduzir
- Trechos relevantes do seu `.zshrc` ou outras configs
- Comportamento esperado x comportamento observado
- Capturas de tela ou logs (se úteis)

Use o template de "Bug" quando disponível.

---

## Sugerindo funcionalidades

Ao propor uma funcionalidade:

- Explique o problema e o benefício para o usuário
- Forneça exemplos ou um esboço de design
- Observe considerações de compatibilidade entre plataformas
- Para mudanças maiores, abra uma discussão ou RFC antes

---

## Contribuições de código (processo de PR)

1. Faça fork do repositório e crie uma branch:

```bash
git clone https://github.com/bernardopg/zshrc-config.git
cd zshrc-config
git checkout -b feature/sua-funcionalidade
```

2. Faça commits pequenos e focados. Siga o formato de mensagem de commit abaixo.
3. Rode verificações e testes locais (veja seção Testes).
4. Envie a branch e abra um PR contra `main` com título e descrição claros.
   Referencie issues relacionados (por exemplo: "Fecha #123").

Checklist de PR:

- [ ] CI passa (se houver)
- [ ] Testes ou instruções de verificação manual incluídos
- [ ] Documentação atualizada
- [ ] Issue relacionada ou motivação clara

---

## Formato de mensagem de commit

Use este formato simples:

```text
tipo(escopo): descrição curta

Descrição longa quando necessário.

Fecha #123
```

Tipos comuns: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`,
`chore`.

---

## Testando localmente

Este projeto usa configurações do Zsh; testes são em sua maioria manuais.

Comandos úteis:

```bash
# Faça backup do .zshrc atual
cp ~/.zshrc ~/.zshrc.backup

# Link para testar o .zshrc deste repositório
ln -sf "$(pwd)/.zshrc" ~/.zshrc

# Abra um shell interativo para testar startup
zsh -i

# Verificação rápida de sintaxe
zsh -n .zshrc

# Meça o tempo de startup
time zsh -i -c exit
```

Teste em múltiplos ambientes quando necessário.

---

## Estilo & qualidade

- Prefira código simples e portátil para shell
- Evite operações lentas no startup
- Documente funções com cabeçalho breve (descrição, args, exemplo)
- Nunca commit segredos ou credenciais

---

## Obter ajuda

- Perguntas: abra uma issue ou discussão
- Relatórios sensíveis: veja contato privado em `CODE_OF_CONDUCT.md`

---

Obrigado por contribuir com o zshrc-config! 🚀
