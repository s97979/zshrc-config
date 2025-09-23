# -*- mode: zsh; sh-shell: zsh; -*-
# ~/.zshrc – UNIVERSAL (Linux, WSL, MSYS2, Cygwin, Git-Bash)
# 26 melhorias embutidas – silenciosas quando não suportadas.

# -----------------------------------------------------------
# 1) Ambiente privado (API keys, etc.) fora do repo
# -----------------------------------------------------------
[[ -f ~/.config/private/env.zsh ]] && source ~/.config/private/env.zsh

# -----------------------------------------------------------
# 2) XDG base dirs
# -----------------------------------------------------------
: ${XDG_CONFIG_HOME:=$HOME/.config}
: ${XDG_CACHE_HOME:=$HOME/.cache}
: ${XDG_STATE_HOME:=$HOME/.local/state}
mkdir -p "$XDG_CACHE_HOME/zsh" "$XDG_STATE_HOME/zsh" 2>/dev/null

# -----------------------------------------------------------
# 3) Histórico universal
# -----------------------------------------------------------
export HISTFILE=${XDG_STATE_HOME}/zsh/history
export HISTSIZE=100000
export SAVEHIST=100000
setopt INC_APPEND_HISTORY_TIME SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_IGNORE_SPACE

# -----------------------------------------------------------
# 4) Shell behaviour
# -----------------------------------------------------------
setopt PROMPT_SUBST INTERACTIVE_COMMENTS AUTO_CD EXTENDED_GLOB NO_BEEP NOTIFY
setopt CORRECT CORRECT_ALL
bindkey -e
SPROMPT='zsh: %R → %r ? [Nyae] '

# -----------------------------------------------------------
# 5) PATH sem duplicatas
# -----------------------------------------------------------
typeset -U path
path=(
    $HOME/.local/bin
    $HOME/bin
    $HOME/.npm-global/bin
    $HOME/Scripts
    $HOME/dev/tools/flutter/bin
    /usr/local/sbin /usr/sbin /sbin
    $path
)
# Windows extras
[[ -d /c/Program\ Files/Docker/Docker/resources/bin ]] && path+=(/c/Program\ Files/Docker/Docker/resources/bin)
[[ -d /mingw64/bin ]] && path+=(/mingw64/bin)
export PATH

# -----------------------------------------------------------
# 6) Cores
# -----------------------------------------------------------
autoload -Uz colors && colors

# -----------------------------------------------------------
# 7) Detecta WSL
# -----------------------------------------------------------
[[ -f /proc/version ]] && grep -qi microsoft /proc/version && WSL=1

# -----------------------------------------------------------
# 8) Oh-My-Zsh (opcional)
# -----------------------------------------------------------
if [[ -d ${ZSH:-$HOME/.oh-my-zsh} ]]; then
    export ZSH=$HOME/.oh-my-zsh
    export ZSH_CACHE_DIR=${XDG_CACHE_HOME}/zsh/omz-cache
    export ZSH_COMPDUMP=${XDG_CACHE_HOME}/zsh/omz-compdump
    ZSH_THEME="robbyrussell"
    plugins=(git fzf colored-man-pages command-not-found history-substring-search zsh-completions zsh-autosuggestions zsh-syntax-highlighting)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    source $ZSH/oh-my-zsh.sh
else
    autoload -Uz compinit
    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ${XDG_CACHE_HOME}/zsh/zcompcache
    compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump
fi

# -----------------------------------------------------------
# 9) Bash completions
# -----------------------------------------------------------
autoload -U +X bashcompinit && bashcompinit
for f in /opt/adguard-cli/bash-completion.sh /opt/adguardvpn_cli/bash-completion.sh; do
    [[ -r $f ]] && source $f
done

# -----------------------------------------------------------
# 10) FZF + FD
# -----------------------------------------------------------
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
elif command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# -----------------------------------------------------------
# 11) Aliases universais
# -----------------------------------------------------------
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --group-directories-first --icons=auto'
    alias ll='eza -lh'
    alias la='eza -lha'
else
    alias ls='ls --color=auto -F'
    alias ll='ls -lh --group-directories-first'
    alias la='ls -lha --group-directories-first'
fi
alias l='ls'
alias ..='cd ..'
alias ...='cd ../..'
alias cp='cp -iv --reflink=auto'
alias mv='mv -iv'
alias rm='rm -Iv'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias wget='wget -c'
alias ports='ss -tulpn 2>/dev/null || netstat -tulpn'
alias serve='python3 -m http.server 8080'
alias json='python3 -m json.tool'
alias urlencode='python3 -c "import sys,urllib.parse as u; print(u.quote_plus(sys.argv[1]))"'
alias urldecode='python3 -c "import sys,urllib.parse as u; print(u.unquote_plus(sys.argv[1]))"'
alias gh='history -i | grep'
alias path='echo $PATH | tr ":" "\n"'
[[ -x $HOME/platformio-env/bin/pio ]] && alias pio=$HOME/platformio-env/bin/pio

# -----------------------------------------------------------
# 12) Funções
# -----------------------------------------------------------
mkcd() { mkdir -p "$1" && cd "$1"; }
bk() { cp -f "$1" "$1.bak"; }
ff() { command find . -type f -iname "*$1*" 2>/dev/null; }
hist() { (( $# )) && history | grep -- "$*" || history; }
extract() {
    [[ -f $1 ]] || { echo "'$1' não é um arquivo válido"; return 1; }
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar e "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.zip) unzip -o "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *.xz) unxz "$1" ;;
        *.lzma) unlzma "$1" ;;
        *) echo "'$1' não pode ser extraído" ;;
    esac
}
killport() {
    local port=$1
    [[ -z $port ]] && { echo "Uso: killport <porta>"; return 1; }
    if command -v lsof >/dev/null; then
        lsof -ti ":$port" | xargs -r kill -9
    elif command -v netstat >/dev/null; then
        netstat -ano | awk -v p=$port '$2==p {print $1}' | xargs -r kill -9
    else
        echo "lsof/netstat não encontrado"; return 1
    fi
}

# -----------------------------------------------------------
# 13) Prompt com git minimal
# -----------------------------------------------------------
git_info() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local b=$(git symbolic-ref --short HEAD 2>/dev/null)
    [[ -n $b ]] && print -n " (%F{green}$b%f)"
}
PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f$(git_info) %# '

# -----------------------------------------------------------
# 14) Modern tools
# -----------------------------------------------------------
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh --cmd cd)"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

if ! alias cat >/dev/null 2>&1; then
    if command -v bat >/dev/null 2>&1; then
        alias cat='bat --paging=never'
    elif command -v batcat >/dev/null 2>&1; then
        alias bat='batcat'
        alias cat='bat --paging=never'
    fi
fi
if ! alias fd >/dev/null 2>&1; then
    if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
        alias fd='fdfind'
    fi
fi

# -----------------------------------------------------------
# 15) Keybindings
# -----------------------------------------------------------
if (( $+functions[history-substring-search-up] )); then
    [[ -n ${terminfo[kcuu1]} ]] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
    [[ -n ${terminfo[kcud1]} ]] && bindkey "${terminfo[kcud1]}" history-substring-search-down
fi
bindkey -M menuselect '^M' .accept-line
setopt NO_LIST_BEEP

# -----------------------------------------------------------
# 16) SSH-Agent
# -----------------------------------------------------------
if [[ -z "$SSH_AUTH_SOCK" ]] && command -v ssh-agent >/dev/null; then
   eval $(ssh-agent -s -t 12h) >/dev/null
   (ssh-add -q ~/.ssh/id_ed25519 ~/.ssh/id_rsa 2>/dev/null &)
fi

# -----------------------------------------------------------
# 17) GPG TTY
# -----------------------------------------------------------
export GPG_TTY=$TTY

# -----------------------------------------------------------
# 18) Docker/Podman
# -----------------------------------------------------------
export DOCKER_BUILDKIT=1 BUILDKIT_PROGRESS=plain
export PODMAN_USERNS=keep-id

# -----------------------------------------------------------
# 19) PIPX 1× only
# -----------------------------------------------------------
[[ -f $XDG_STATE_HOME/zsh/pipx-ensured ]] || {
    pipx ensurepath 2>/dev/null && touch $XDG_STATE_HOME/zsh/pipx-ensured
}

# -----------------------------------------------------------
# 20) UPDATE FUNCTION (v2.1) – COLE AQUI SEU BLOCO ORIGINAL
# -----------------------------------------------------------
# (Cole o conteúdo INTEIRO da função update() que você já possui)

# -----------------------------------------------------------
# 21) Completion para update
# -----------------------------------------------------------
_update_completion() {
    local -a opts managers
    opts=(
        '-n:Dry run' '--dry-run:Simulate' '-y:Non-interactive' '--yes:Auto-confirm'
        '-q:Quiet' '--quiet:Minimal output' '-v:Verbose' '--verbose:Detailed'
        '-f:Force' '--force:Continue even with warnings' '-h:Help' '--help:Usage'
        '--all:Everything' '--system:System only' '--dev:Dev tools' '--lang:Languages'
        '--frameworks:Shell frameworks' '--include-phased:Phased updates'
        '--security-only:Security only' '--cleanup:Clean caches' '--no-stats:Skip summary'
    )
    managers=(apt snap flatpak brew nix pipx npm yarn pnpm cargo rust gem composer go flutter docker podman conda mamba asdf sdkman ohmyzsh antigen zinit platformio firmware)
    _arguments -C \
        '(--dry-run -n)'{-n,--dry-run}'[Simulate]' \
        '(--yes -y)'{-y,--yes}'[Non-interactive]' \
        '(--quiet -q)'{-q,--quiet}'[Minimal]' \
        '(--verbose -v)'{-v,--verbose}'[Detailed]' \
        '(--force -f)'{-f,--force}'[Force]' \
        '(--help -h)'{-h,--help}'[Help]' \
        '--all[Everything]' '--system[System]' '--dev[Dev]' '--lang[Lang]' '--frameworks[Frameworks]' \
        '--only[Only]:managers:(${managers})' '--exclude[Exclude]:managers:(${managers})' \
        '--include-phased[Phased]' '--security-only[Security]' '--cleanup[Clean]' \
        '--kernels-keep[Keep]:number:' '--max-retries[Retries]:number:' '--timeout[Timeout]:seconds:' \
        '--log-keep[Logs]:number:' '--no-stats[Skip summary]'
}
compdef _update_completion update update_system up
alias update_system='update'
alias up='update'

# -----------------------------------------------------------
# 22) Reload
# -----------------------------------------------------------
reload-zsh() { exec zsh }
alias rz='reload-zsh'

# -----------------------------------------------------------
# 23) Health-check
# -----------------------------------------------------------
zsh-health() {
    printf 'zsh cache: %s\n' "$(du -sh $XDG_CACHE_HOME/zsh 2>/dev/null | cut -f1)"
    printf 'zoxide: %s\n' "$(command -v zoxide >/dev/null && echo ok || echo no)"
    printf 'PATH dirs: %d\n' ${#path}
    printf 'History: %d\n' $(history -n | wc -l)
}

# -----------------------------------------------------------
# 24) Local overrides
# -----------------------------------------------------------
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local

# -----------------------------------------------------------
# 25) Compile
# -----------------------------------------------------------
if [[ ! -f ${ZDOTDIR:-$HOME}/.zshrc.zwc || ~/.zshrc -nt ${ZDOTDIR:-$HOME}/.zshrc.zwc ]]; then
    zcompile -R ${ZDOTDIR:-$HOME}/.zshrc.zwc ~/.zshrc 2>/dev/null
fi