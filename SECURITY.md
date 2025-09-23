# Security Policy

## Supported Versions

We actively support the following versions of this project:

| Version | Supported          |
| ------- | ------------------ |
| Latest  | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

If you discover a security vulnerability in this zsh configuration repository, please report it to us through one of the following methods:

### Preferred Method: GitHub Security Advisory

1. Go to the [Security tab](https://github.com/bernardopg/zshrc-config/security) of this repository
2. Click "Report a vulnerability"
3. Fill out the security advisory form with detailed information

### Alternative Method: Email

Send an email to: **security@[domain]** (replace with your actual contact)

Please include the following information in your report:

- Description of the vulnerability
- Steps to reproduce the issue
- Potential impact
- Suggested fix (if you have one)

## Response Timeline

- **Initial Response**: Within 48 hours of receiving the report
- **Status Update**: Within 1 week with preliminary analysis
- **Resolution**: Target resolution within 30 days for critical issues

## Security Best Practices

### For Users

When using this zsh configuration:

1. **Never commit sensitive data**:

   ```bash
   # ✅ Good: Use the private config pattern
   echo 'export API_KEY="your-key"' >> ~/.config/private/env.zsh

   # ❌ Bad: Never put secrets in your .zshrc
   export API_KEY="sk-1234567890abcdef"
   ```

2. **Set proper file permissions**:

   ```bash
   chmod 600 ~/.config/private/env.zsh
   chmod 700 ~/.config/private/
   ```

3. **Review scripts before sourcing**:
   - Always inspect downloaded zsh configurations
   - Understand what functions and aliases do before using them

4. **Keep your shell updated**:

   ```bash
   # Update your zsh and related tools regularly
   sudo apt update && sudo apt upgrade zsh  # Ubuntu/Debian
   brew upgrade zsh                         # macOS
   ```

### For Contributors

1. **Sanitize code examples**: Remove any real API keys, passwords, or personal information
2. **Review dependencies**: Ensure any suggested plugins or tools are from trusted sources
3. **Test security implications**: Consider how new features might expose sensitive information
4. **Follow secure coding practices**: Validate inputs, avoid command injection vulnerabilities

## Common Security Considerations

### Command Injection Prevention

```bash
# ✅ Good: Properly quote variables
rm "$file_to_delete"

# ❌ Bad: Unquoted variables can lead to injection
rm $file_to_delete
```

### Avoiding Malicious Aliases

```bash
# ✅ Good: Explicit, clear aliases
alias ll='ls -la'

# ❌ Suspicious: Obfuscated or suspicious commands
alias ls='rm -rf'  # Never do this!
```

### Path Security

```bash
# ✅ Good: Add paths safely
export PATH="$HOME/.local/bin:$PATH"

# ❌ Risky: Putting current directory in PATH
export PATH=".:$PATH"
```

## Dependencies and Third-Party Tools

We recommend using tools from trusted sources:

- **Package managers**: Use official repositories (apt, brew, etc.)
- **Oh My Zsh plugins**: Verify plugins are from the official repository
- **Custom scripts**: Review before sourcing from unknown sources

## Disclosure Policy

- We follow responsible disclosure practices
- We will credit security researchers who responsibly report vulnerabilities
- We will provide updates on the status of reported vulnerabilities

## Security Updates

Security updates will be:

- Released as soon as possible after verification
- Announced in GitHub releases with security tags
- Documented in the changelog with severity levels

## Contact

For security-related questions or concerns:

- GitHub Security Advisory (preferred)
- Email: [bernardo.gomes@bebitterbebetter.com.br](mailto:bernardo.gomes@bebitterbebetter.com.br)
- Open a regular issue for non-sensitive security discussions

---

**Note**: This project handles shell configuration, which has inherent security implications. Always review and understand any shell configuration before using it in your environment.

---

## Português (Brasil)

Política de Segurança

## Versões Suportadas

Damos suporte ativo às seguintes versões deste projeto:

| Versão | Suportada          |
| ------- | ------------------ |
| Mais Recente  | :white_check_mark: |
| < 1.0   | :x:                |

## Relatando uma Vulnerabilidade

**Por favor, não relate vulnerabilidades de segurança através de issues públicos do GitHub.**

Se você descobrir uma vulnerabilidade de segurança neste repositório de configuração zsh, relate-a para nós através de um dos seguintes métodos:

### Método Preferido: Aviso de Segurança do GitHub

1. Vá para a [aba Security](https://github.com/bernardopg/zshrc-config/security) deste repositório
2. Clique em "Report a vulnerability"
3. Preencha o formulário de aviso de segurança com informações detalhadas

### Método Alternativo: Email

Envie um email para: **[bernardo.gomes@bebitterbebetter.com.br](mailto:bernardo.gomes@bebitterbebetter.com.br)**

Inclua as seguintes informações no seu relatório:

- Descrição da vulnerabilidade
- Passos para reproduzir o problema
- Impacto potencial
- Correção sugerida (se você tiver uma)

## Cronograma de Resposta

- **Resposta Inicial**: Dentro de 48 horas após receber o relatório
- **Atualização de Status**: Dentro de 1 semana com análise preliminar
- **Resolução**: Meta de resolução dentro de 30 dias para problemas críticos

## Melhores Práticas de Segurança

### Para Usuários

Ao usar esta configuração zsh:

1. **Nunca commite dados sensíveis**:

   ```bash
   # ✅ Bom: Use o padrão de configuração privada
   echo 'export API_KEY="sua-chave"' >> ~/.config/private/env.zsh

   # ❌ Ruim: Nunca coloque segredos no seu .zshrc
   export API_KEY="sk-1234567890abcdef"
   ```

2. **Defina permissões adequadas de arquivo**:

   ```bash
   chmod 600 ~/.config/private/env.zsh
   chmod 700 ~/.config/private/
   ```

3. **Revise scripts antes de sourcá-los**:
   - Sempre inspecione configurações zsh baixadas
   - Entenda o que funções e aliases fazem antes de usá-los

4. **Mantenha seu shell atualizado**:

   ```bash
   # Atualize seu zsh e ferramentas relacionadas regularmente
   sudo apt update && sudo apt upgrade zsh  # Ubuntu/Debian
   brew upgrade zsh                         # macOS
   ```

### Para Contribuintes

1. **Limpe exemplos de código**: Remova quaisquer chaves de API reais, senhas ou informações pessoais
2. **Revise dependências**: Garanta que plugins ou ferramentas sugeridas sejam de fontes confiáveis
3. **Teste implicações de segurança**: Considere como novas funcionalidades podem expor informações sensíveis
4. **Siga práticas de codificação segura**: Valide entradas, evite vulnerabilidades de injeção de comando

## Considerações de Segurança Comuns

### Prevenção de Injeção de Comando

```bash
# ✅ Bom: Cite variáveis adequadamente
rm "$arquivo_para_deletar"

# ❌ Ruim: Variáveis não citadas podem levar a injeção
rm $arquivo_para_deletar
```

### Evitando Aliases Maliciosos

```bash
# ✅ Bom: Aliases explícitos, claros
alias ll='ls -la'

# ❌ Suspeito: Comandos ofuscados ou suspeitos
alias ls='rm -rf'  # Nunca faça isso!
```

### Segurança de Caminho

```bash
# ✅ Bom: Adicione caminhos com segurança
export PATH="$HOME/.local/bin:$PATH"

# ❌ Arriscado: Colocar diretório atual no PATH
export PATH=".:$PATH"
```

## Dependências e Ferramentas de Terceiros

Recomendamos usar ferramentas de fontes confiáveis:

- **Gerenciadores de pacotes**: Use repositórios oficiais (apt, brew, etc.)
- **Plugins Oh My Zsh**: Verifique se plugins são do repositório oficial
- **Scripts personalizados**: Revise antes de sourcá-los de fontes desconhecidas

## Política de Divulgação

- Seguimos práticas de divulgação responsável
- Creditaremos pesquisadores de segurança que reportarem vulnerabilidades de forma responsável
- Forneceremos atualizações sobre o status de vulnerabilidades reportadas

## Atualizações de Segurança

Atualizações de segurança serão:

- Lançadas o mais rápido possível após verificação
- Anunciadas em releases do GitHub com tags de segurança
- Documentadas no changelog com níveis de severidade

## Contato

Para perguntas ou preocupações relacionadas à segurança:

- Aviso de Segurança do GitHub (preferido)
- Email: [bernardo.gomes@bebitterbebetter.com.br](mailto:bernardo.gomes@bebitterbebetter.com.br)
- Abra um issue regular para discussões de segurança não sensíveis

---

**Nota**: Este projeto lida com configuração de shell, que tem implicações de segurança inerentes. Sempre revise e entenda qualquer configuração de shell antes de usá-la no seu ambiente.
