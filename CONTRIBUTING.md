# Contributing to zshrc-config

🎉 Thanks for your interest in contributing to zshrc-config! This guide will help you get started.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Contribution Guidelines](#contribution-guidelines)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

### 🐛 Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates.

**How to submit a good bug report:**

1. Use the bug report template
2. Include your environment details:
   - OS (Linux, macOS, Windows/WSL)
   - Zsh version (`zsh --version`)
   - Terminal emulator
3. Provide steps to reproduce
4. Include relevant configuration snippets
5. Add screenshots if applicable

### 💡 Suggesting Features

Feature suggestions are welcome! Please:

1. Use the feature request template
2. Explain the use case and benefits
3. Consider cross-platform compatibility
4. Provide examples if possible

### 🔧 Contributing Code

Areas where contributions are especially welcome:

- **Aliases and functions**: Useful, portable shell helpers
- **Cross-platform compatibility**: Ensuring features work on Linux, macOS, Windows
- **Performance improvements**: Making shell startup faster
- **Documentation**: Examples, guides, translations
- **Security**: Identifying and fixing security issues

## Development Setup

### Prerequisites

- Zsh (version 5.0+)
- Git
- Text editor of your choice

### Local Development

1. **Fork and clone the repository**:

   ```bash
   git clone https://github.com/YOUR_USERNAME/zshrc-config.git
   cd zshrc-config
   ```

2. **Create a test environment**:

   ```bash
   # Create a backup of your current config
   cp ~/.zshrc ~/.zshrc.backup

   # Test the new configuration
   ln -sf "$(pwd)/.zshrc" ~/.zshrc

   # Start a new shell to test
   zsh
   ```

3. **Create a feature branch**:

   ```bash
   git checkout -b feature/your-feature-name
   ```

### Testing Your Changes

1. **Test across different environments**:
   - Linux (Ubuntu, Fedora, etc.)
   - macOS
   - Windows (WSL, Git Bash, MSYS2)

2. **Verify shell startup performance**:

   ```bash
   # Time shell startup
   time zsh -i -c exit

   # Check for syntax errors
   zsh -n .zshrc
   ```

3. **Test with clean environment**:

   ```bash
   # Test without existing zsh configuration
   env -i HOME="$HOME" zsh -l
   ```

## Contribution Guidelines

### General Principles

- **Portability**: Code should work across different platforms
- **Performance**: Avoid slow operations during shell startup
- **Security**: Never include secrets or enable risky behaviors
- **Simplicity**: Keep functions and aliases simple and well-documented

### What We Accept

✅ **Good contributions:**

- Cross-platform aliases and functions
- Performance optimizations
- Security improvements
- Documentation improvements
- Bug fixes
- Test improvements

❌ **Please avoid:**

- Platform-specific code without fallbacks
- Overly complex functions
- Breaking changes without migration path
- Undocumented features
- Security vulnerabilities

## Pull Request Process

### Before Submitting

1. **Ensure your code follows our style guidelines**
2. **Add tests for new functionality**
3. **Update documentation**
4. **Test on multiple platforms**
5. **Check for security implications**

### PR Requirements

1. **Clear title and description**
2. **Reference related issues**
3. **Include testing information**
4. **Screenshots/demos for UI changes**
5. **Update CHANGELOG.md if applicable**

### Review Process

1. **Automated checks**: CI will run basic tests
2. **Code review**: At least one maintainer will review
3. **Testing**: We may test on different environments
4. **Discussion**: Address feedback and questions
5. **Merge**: Once approved, we'll merge your changes

## Style Guidelines

### Shell Code Style

```bash
# ✅ Good: Clear function names and documentation
# Description: Update all package managers
# Usage: update [--dry-run] [--system-only]
function update() {
    local dry_run=false
    local system_only=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run)
                dry_run=true
                shift
                ;;
            --system-only)
                system_only=true
                shift
                ;;
            *)
                echo "Unknown option: $1" >&2
                return 1
                ;;
        esac
    done

    # Implementation...
}

# ✅ Good: Simple, descriptive aliases
alias ll='ls -la'
alias grep='grep --color=auto'

# ❌ Bad: Unclear or dangerous aliases
alias rm='rm -rf'  # Dangerous!
alias x='exit'     # Too short, unclear
```

### Documentation Style

```bash
# Function documentation template:
# Description: Brief description of what the function does
# Arguments:
#   $1 - Description of first argument
#   $2 - Description of second argument
# Options:
#   --flag - Description of flag
# Returns: Description of return value/behavior
# Example: function_name arg1 arg2 --flag
function function_name() {
    # Implementation
}
```

### Commit Message Format

```text
type(scope): brief description

Longer description if needed.

- List changes if multiple
- Use present tense
- Reference issues with #123

Closes #123
```

**Types:**

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style changes
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `test`: Testing
- `chore`: Maintenance

## Testing

### Manual Testing Checklist

- [ ] Shell starts without errors
- [ ] All functions work as expected
- [ ] Aliases are properly defined
- [ ] Cross-platform compatibility verified
- [ ] Performance impact is minimal
- [ ] Security implications considered

### Automated Testing

We encourage adding automated tests for new features:

```bash
# Example test structure
test_function_name() {
    # Setup
    local expected="expected_output"

    # Execute
    local actual=$(your_function test_input)

    # Verify
    if [[ "$actual" != "$expected" ]]; then
        echo "Test failed: expected '$expected', got '$actual'"
        return 1
    fi

    echo "Test passed"
}
```

## Documentation

### README Updates

When adding features, update the README:

- Add new functions to the commands table
- Update installation instructions if needed
- Add examples for complex features

### Code Comments

- Document complex logic
- Explain platform-specific workarounds
- Add usage examples for functions

## Getting Help

- **Questions**: Open a discussion or issue
- **Chat**: Join our community discussions
- **Email**: Contact maintainers for sensitive topics

## Recognition

Contributors will be:

- Listed in the project contributors
- Credited in release notes for significant contributions
- Thanked in the community

---

Thank you for contributing to zshrc-config! 🚀

---

## Português (Brasil)

Contribuindo para zshrc-config

🎉 Obrigado pelo seu interesse em contribuir para zshrc-config! Este guia irá ajudá-lo a começar.

## Índice

- [Código de Conduta](#código-de-conduta)
- [Como Posso Contribuir?](#como-posso-contribuir)
- [Configuração de Desenvolvimento](#configuração-de-desenvolvimento)
- [Diretrizes de Contribuição](#diretrizes-de-contribuição)
- [Processo de Pull Request](#processo-de-pull-request)
- [Diretrizes de Estilo](#diretrizes-de-estilo)
- [Testes](#testes)
- [Documentação](#documentação)

## Código de Conduta

Este projeto e todos os participantes são regidos pelo nosso [Código de Conduta](CODE_OF_CONDUCT.md). Ao participar, você deve respeitar este código.

## Como Posso Contribuir?

### 🐛 Relatando Bugs

Antes de criar relatórios de bugs, verifique os issues existentes para evitar duplicatas.

**Como enviar um bom relatório de bug:**

1. Use o template de relatório de bug
2. Inclua detalhes do seu ambiente:
   - SO (Linux, macOS, Windows/WSL)
   - Versão do Zsh (`zsh --version`)
   - Emulador de terminal
3. Forneça passos para reproduzir
4. Inclua trechos de configuração relevantes
5. Adicione capturas de tela se aplicável

### 💡 Sugerindo Funcionalidades

Sugestões de funcionalidades são bem-vindas! Por favor:

1. Use o template de solicitação de funcionalidade
2. Explique o caso de uso e benefícios
3. Considere compatibilidade entre plataformas
4. Forneça exemplos se possível

### 🔧 Contribuindo com Código

Áreas onde contribuições são especialmente bem-vindas:

- **Aliases e funções**: Helpers úteis e portáteis para shell
- **Compatibilidade entre plataformas**: Garantindo que funcionalidades funcionem no Linux, macOS, Windows
- **Melhorias de performance**: Tornando o startup do shell mais rápido
- **Documentação**: Exemplos, guias, traduções
- **Segurança**: Identificando e corrigindo problemas de segurança

## Configuração de Desenvolvimento

### Pré-requisitos

- Zsh (versão 5.0+)
- Git
- Editor de texto de sua escolha

### Desenvolvimento Local

1. **Fork e clone o repositório**:

   ```bash
   git clone https://github.com/SEU_USERNAME/zshrc-config.git
   cd zshrc-config
   ```

2. **Crie um ambiente de teste**:

   ```bash
   # Crie um backup da sua configuração atual
   cp ~/.zshrc ~/.zshrc.backup

   # Teste a nova configuração
   ln -sf "$(pwd)/.zshrc" ~/.zshrc

   # Inicie um novo shell para testar
   zsh
   ```

3. **Crie uma branch de funcionalidade**:

   ```bash
   git checkout -b feature/sua-funcionalidade
   ```

### Testando Suas Mudanças

1. **Teste em diferentes ambientes**:
   - Linux (Ubuntu, Fedora, etc.)
   - macOS
   - Windows (WSL, Git Bash, MSYS2)

2. **Verifique a performance do startup do shell**:

   ```bash
   # Cronometre o startup do shell
   time zsh -i -c exit

   # Verifique erros de sintaxe
   zsh -n .zshrc
   ```

3. **Teste com ambiente limpo**:

   ```bash
   # Teste sem configuração zsh existente
   env -i HOME="$HOME" zsh -l
   ```

## Diretrizes de Contribuição

### Princípios Gerais

- **Portabilidade**: O código deve funcionar em diferentes plataformas
- **Performance**: Evite operações lentas durante o startup do shell
- **Segurança**: Nunca inclua segredos ou habilite comportamentos arriscados
- **Simplicidade**: Mantenha funções e aliases simples e bem-documentados

### O Que Aceitamos

✅ **Boas contribuições:**

- Aliases e funções entre plataformas
- Otimizações de performance
- Melhorias de segurança
- Melhorias na documentação
- Correções de bugs
- Melhorias nos testes

❌ **Por favor evite:**

- Código específico de plataforma sem fallbacks
- Funções excessivamente complexas
- Mudanças disruptivas sem caminho de migração
- Funcionalidades não documentadas
- Vulnerabilidades de segurança

## Processo de Pull Request

### Antes de Enviar

1. **Garanta que seu código siga nossas diretrizes de estilo**
2. **Adicione testes para novas funcionalidades**
3. **Atualize a documentação**
4. **Teste em múltiplas plataformas**
5. **Verifique implicações de segurança**

### Requisitos do PR

1. **Título e descrição claros**
2. **Referencie issues relacionados**
3. **Inclua informações de teste**
4. **Capturas de tela/demos para mudanças de UI**
5. **Atualize CHANGELOG.md se aplicável**

### Processo de Revisão

1. **Verificações automatizadas**: CI executará testes básicos
2. **Revisão de código**: Pelo menos um maintainer irá revisar
3. **Teste**: Podemos testar em diferentes ambientes
4. **Discussão**: Aborde feedback e perguntas
5. **Merge**: Uma vez aprovado, faremos merge das suas mudanças

## Diretrizes de Estilo

### Estilo de Código Shell

```bash
# ✅ Bom: Nomes de função claros e documentação
# Descrição: Atualizar todos os gerenciadores de pacotes
# Uso: update [--dry-run] [--system-only]
function update() {
    local dry_run=false
    local system_only=false

    # Parse argumentos
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run)
                dry_run=true
                shift
                ;;
            --system-only)
                system_only=true
                shift
                ;;
            *)
                echo "Opção desconhecida: $1" >&2
                return 1
                ;;
        esac
    done

    # Implementação...
}

# ✅ Bom: Aliases simples, descritivos
alias ll='ls -la'
alias grep='grep --color=auto'

# ❌ Ruim: Aliases pouco claros ou perigosos
alias rm='rm -rf'  # Perigoso!
alias x='exit'     # Muito curto, pouco claro
```

### Estilo de Documentação

```bash
# Template de documentação de função:
# Descrição: Breve descrição do que a função faz
# Argumentos:
#   $1 - Descrição do primeiro argumento
#   $2 - Descrição do segundo argumento
# Opções:
#   --flag - Descrição da flag
# Retorna: Descrição do valor de retorno/comportamento
# Exemplo: nome_funcao arg1 arg2 --flag
function nome_funcao() {
    # Implementação
}
```

### Formato de Mensagem de Commit

```text
tipo(escopo): breve descrição

Descrição mais longa se necessário.

- Liste mudanças se múltiplas
- Use tempo presente
- Referencie issues com #123

Fecha #123
```

**Tipos:**

- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Documentação
- `style`: Mudanças de estilo de código
- `refactor`: Refatoração de código
- `perf`: Melhoria de performance
- `test`: Testes
- `chore`: Manutenção

## Testes

### Lista de Verificação de Teste Manual

- [ ] Shell inicia sem erros
- [ ] Todas as funções funcionam como esperado
- [ ] Aliases são definidos corretamente
- [ ] Compatibilidade entre plataformas verificada
- [ ] Impacto na performance é mínimo
- [ ] Implicações de segurança consideradas

### Testes Automatizados

Incentivamos adicionar testes automatizados para novas funcionalidades:

```bash
# Estrutura de teste exemplo
test_nome_funcao() {
    # Setup
    local esperado="saida_esperada"

    # Execute
    local atual=$(sua_funcao entrada_teste)

    # Verifique
    if [[ "$atual" != "$esperado" ]]; then
        echo "Teste falhou: esperado '$esperado', obteve '$atual'"
        return 1
    fi

    echo "Teste passou"
}
```

## Documentação

### Atualizações do README

Ao adicionar funcionalidades, atualize o README:

- Adicione novas funções à tabela de comandos
- Atualize instruções de instalação se necessário
- Adicione exemplos para funcionalidades complexas

### Comentários no Código

- Documente lógica complexa
- Explique workarounds específicos de plataforma
- Adicione exemplos de uso para funções

## Obtendo Ajuda

- **Perguntas**: Abra uma discussão ou issue
- **Chat**: Junte-se às discussões da comunidade
- **Email**: Contate maintainers para tópicos sensíveis

## Reconhecimento

Contribuintes serão:

- Listados nos contribuidores do projeto
- Creditados nas notas de release para contribuições significativas
- Agradecidos na comunidade

---

Obrigado por contribuir para zshrc-config! 🚀
