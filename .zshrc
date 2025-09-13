# Modern minimal zshrc for Ubuntu zsh 5.9
# Safe defaults, fast completion, lean aliases, and a robust system update function.
# Backup of previous config should be in ~/.local/backups

# XDG base dirs defaults
: ${XDG_CONFIG_HOME:=$HOME/.config}
: ${XDG_CACHE_HOME:=$HOME/.cache}
: ${XDG_STATE_HOME:=$HOME/.local/state}
mkdir -p "$XDG_CACHE_HOME/zsh" "$XDG_STATE_HOME/zsh"

# History
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt INC_APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_IGNORE_SPACE

# Shell behavior
setopt PROMPT_SUBST INTERACTIVE_COMMENTS
setopt AUTO_CD EXTENDED_GLOB NO_BEEP NOTIFY
bindkey -e

# Paths
path_prepend() { case ":$PATH:" in *":$1:"*) ;; *) PATH="$1:$PATH";; esac }
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
export PATH

# Colors
autoload -Uz colors && colors

# Completion
autoload -Uz compinit
if [[ -d "${ZSH:-$HOME/.oh-my-zsh}" ]]; then
  export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
  export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh/omz-cache"
  export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/omz-compdump"
  ZSH_THEME="robbyrussell"
  plugins=(git fzf colored-man-pages command-not-found history-substring-search zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

  # Autosuggestions (UX)
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=1

  # FZF (UX)
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
  # Preferir fd; se só houver fdfind (Ubuntu), criar alias fd e usar no FZF
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  elif command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  source "$ZSH/oh-my-zsh.sh"
else
  zstyle ':completion:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  zstyle ':completion:*' use-cache yes
  zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
  compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
fi

# Enable bash-style completions if available (for some vendor scripts)
autoload -U +X bashcompinit && bashcompinit
for f in /opt/adguard-cli/bash-completion.sh /opt/adguardvpn_cli/bash-completion.sh; do
  [ -r "$f" ] && source "$f"
done

# Lean aliases
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
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
# Extra utilities
alias ports='ss -tulpn'
alias serve='python3 -m http.server'
alias json='python3 -m json.tool'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))"'
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
[ -x "$HOME/platformio-env/bin/pio" ] && alias pio="$HOME/platformio-env/bin/pio"

# Handy functions
mkcd() { mkdir -p "$1" && cd "$1"; }
bk() { cp -f "$1" "$1.bak"; }
ff() { command find . -type f -iname "*$1*" 2>/dev/null; }
hist() { if (( $# == 0 )); then history; else history | grep -- "$1"; fi }
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar e "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip -o "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *.xz)      unxz "$1" ;;
      *.lzma)    unlzma "$1" ;;
      *) echo "'$1' não pode ser extraído" ;;
    esac
  else
    echo "'$1' não é um arquivo válido"
  fi
}
killport() {
  local port="$1"
  if [ -z "$port" ]; then echo "Uso: killport <porta>"; return 2; fi
  sudo fuser -k -n tcp "$port" 2>/dev/null || lsof -t -i ":$port" | xargs -r kill -9
}

# Prompt
PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f %# '

# Optional modern tools
if command -v zoxide >/dev/null 2>&1; then eval "$(zoxide init zsh --cmd cd)"; fi
if command -v starship >/dev/null 2>&1; then eval "$(starship init zsh)"; fi

# Skip pip updates on modern Ubuntu (PEP 668)
export SYSUPDATE_SKIP_PIP=1

# ════════════════════════════════════════════════════════════════════════════════════════════════
# Advanced Ubuntu System Update Function v2.1
# ────────────────────────────────────────────────────────────────────────────────────────────────
# Comprehensive system updater with intelligent detection, selective updates, and robust error handling
# Usage: update [options]
# Run 'update --help' for full documentation
# ════════════════════════════════════════════════════════════════════════════════════════════════

update() {
  emulate -L zsh -o nounset -o pipefail
  setopt localtraps

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Configuration & Defaults
  # ─────────────────────────────────────────────────────────────────────────────────────────────
  local -r VERSION="2.1.0"
  local -r STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/sysupdate"
  local -r LOG_DIR="$STATE_DIR/logs"
  local -r BACKUP_DIR="$STATE_DIR/backups"
  local -r CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/sysupdate"

  # Logging state
  local LOGFILE=""
  local -i LOG_REDIR_ACTIVE=0

  # Defaults (can be overridden by environment variables)
  local -i LOG_KEEP=${SYSUPDATE_LOG_KEEP:-10}
  local -i KERNELS_KEEP=${SYSUPDATE_KERNELS_KEEP:-2}
  local -i MAX_RETRIES=${SYSUPDATE_MAX_RETRIES:-3}
  local -i TIMEOUT=${SYSUPDATE_TIMEOUT:-300}
  local -i VERBOSE=${SYSUPDATE_VERBOSE:-0}

  # Flags
  local -i dryrun=0 quiet=0 force=0 cleanup=0 interactive=1
  local -i include_phased=0 security_only=0 show_stats=1
  local -a include_managers=() exclude_managers=()
  local scope="all"  # all, system, dev, lang, frameworks

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Color Support
  # ─────────────────────────────────────────────────────────────────────────────────────────────
  local -A colors
  if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
    colors=(
      [reset]="$(tput sgr0)"
      [bold]="$(tput bold)"
      [dim]="$(tput dim)"
      [red]="$(tput setaf 1)"
      [green]="$(tput setaf 2)"
      [yellow]="$(tput setaf 3)"
      [blue]="$(tput setaf 4)"
      [magenta]="$(tput setaf 5)"
      [cyan]="$(tput setaf 6)"
    )
  else
    colors=([reset]="" [bold]="" [dim]="" [red]="" [green]="" [yellow]="" [blue]="" [magenta]="" [cyan]="")
  fi

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Helper Functions
  # ─────────────────────────────────────────────────────────────────────────────────────────────

  # Logging functions
  log_init() {
    mkdir -p "$LOG_DIR" "$BACKUP_DIR" "$CACHE_DIR"
    chmod 700 "$STATE_DIR"
    local timestamp="$(date +%Y%m%d-%H%M%S)"
    LOGFILE="$LOG_DIR/sysupdate-$timestamp.log"
    if (( ! dryrun )); then
      exec 3>&1 4>&2
      exec 1> >(tee -a "$LOGFILE")
      exec 2> >(tee -a "$LOGFILE" >&2)
      LOG_REDIR_ACTIVE=1
      trap update__sig_cleanup INT TERM
    fi
    log_rotate
  }

  log_rotate() {
    local -a logs=("$LOG_DIR"/sysupdate-*.log(.N))
    if (( ${#logs} > LOG_KEEP )); then
      local -i to_remove=$((${#logs} - LOG_KEEP))
      for ((i=1; i<=to_remove; i++)); do
        rm -f "${logs[i]}"
      done
    fi
  }

  msg() { (( quiet )) || echo "${colors[green]}►${colors[reset]} $*"; }
  info() { (( quiet )) || echo "${colors[blue]}ℹ${colors[reset]} $*"; }
  warn() { echo "${colors[yellow]}⚠${colors[reset]} $*" >&2; }
  error() { echo "${colors[red]}✖${colors[reset]} $*" >&2; }
  success() { (( quiet )) || echo "${colors[green]}✓${colors[reset]} $*"; }
  section() {
    (( quiet )) && return
    echo ""
    echo "${colors[bold]}${colors[cyan]}═══ $* ═══${colors[reset]}"
  }

  # Progress spinner
  local spinner_pid=0
  spinner_start() {
    (( quiet || dryrun )) && return
    ( while true; do
        for s in ⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏; do
          printf "\r${colors[cyan]}$s${colors[reset]} $1..."
          sleep 0.1
        done
      done ) &
    spinner_pid=$!
  }

  spinner_stop() {
    if (( spinner_pid > 0 )); then
      kill $spinner_pid 2>/dev/null
      wait $spinner_pid 2>/dev/null
      spinner_pid=0
      printf "\r\033[K"
    fi
  }

  # Cleanup handler to restore stdout/stderr and terminate background helpers
  update__cleanup() {
    # Stop spinner if running
    spinner_stop

    # Kill sudo keepalive loop if present
    [[ -n "${sudo_pid:-}" ]] && kill $sudo_pid 2>/dev/null

    # Restore original stdout/stderr and close backups
    if (( LOG_REDIR_ACTIVE )); then
      exec 1>&3 2>&4
      exec 3>&- 4>&-
      LOG_REDIR_ACTIVE=0
    fi
  }

  # Always cleanup on signals
  update__sig_cleanup() {
    update__cleanup
    return 130
  }

  # Command execution with retries (FIXED)
  run_cmd() {
    local cmd="$1"
    local -i retries=${2:-$MAX_RETRIES}
    local -i retry_count=0
    local -i ret=0

    while (( retry_count < retries )); do
      if (( dryrun )); then
        info "[DRY-RUN] Would execute: $cmd"
        return 0
      fi

      # Use eval safely with proper error handling
      if eval "$cmd" 2>/dev/null; then
        return 0
      fi
      ret=$?
      ((retry_count++))
      if (( retry_count < retries )); then
        warn "Command failed (attempt $retry_count/$retries), retrying..."
        sleep $((retry_count * 2))
      fi
    done

    return $ret
  }

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Argument Parsing
  # ─────────────────────────────────────────────────────────────────────────────────────────────
  while (( $# )); do
    case "$1" in
      # Main operations
      -n|--dry-run) dryrun=1 ;;
      -y|--yes) interactive=0 ;;
      -q|--quiet) quiet=1; show_stats=0 ;;
      -v|--verbose) VERBOSE=1 ;;
      -f|--force) force=1 ;;

      # Scope selectors
      --all) scope="all" ;;
      --system) scope="system" ;;
      --dev) scope="dev" ;;
      --lang) scope="lang" ;;
      --frameworks) scope="frameworks" ;;

      # Package manager selection
      --only)
        shift
        IFS=',' read -A include_managers <<< "$1"
        ;;
      --exclude)
        shift
        IFS=',' read -A exclude_managers <<< "$1"
        ;;

      # APT options
      --include-phased) include_phased=1 ;;
      --security-only) security_only=1 ;;

      # Cleanup options
      --cleanup) cleanup=1 ;;
      --kernels-keep)
        shift
        KERNELS_KEEP="$1"
        ;;

      # Advanced options
      --max-retries)
        shift
        MAX_RETRIES="$1"
        ;;
      --timeout)
        shift
        TIMEOUT="$1"
        ;;
      --log-keep)
        shift
        LOG_KEEP="$1"
        ;;
      --no-stats) show_stats=0 ;;

      # Help
      -h|--help)
        cat <<'HELP'
Advanced Ubuntu System Update Function v2.1

Usage: update [options]

BASIC OPTIONS:
  -n, --dry-run         Simulate updates without making changes
  -y, --yes             Non-interactive mode (auto-confirm)
  -q, --quiet           Minimal output
  -v, --verbose         Detailed output
  -f, --force           Force operations even with warnings
  -h, --help            Show this help message

SCOPE SELECTION:
  --all                 Update everything (default)
  --system              System packages only (apt, snap, flatpak, firmware)
  --dev                 Development tools (compilers, SDKs, containers)
  --lang                Language ecosystems (Python, Node, Rust, etc.)
  --frameworks          Shell frameworks (Oh My Zsh, etc.)

PACKAGE MANAGER SELECTION:
  --only <pm1,pm2>      Only update specified package managers
  --exclude <pm1,pm2>   Exclude specified package managers

  Available managers:
    System: apt, snap, flatpak, brew, nix
    Languages: pipx, npm, yarn, pnpm, cargo, gem, composer
    Tools: docker, podman, conda, mamba, asdf, sdkman
    Frameworks: ohmyzsh, antigen, zinit, zplug

APT OPTIONS:
  --include-phased      Include phased updates (Ubuntu)
  --security-only       Security updates only

CLEANUP OPTIONS:
  --cleanup             Clean caches and remove old packages
  --kernels-keep <N>    Keep N recent kernels (default: 2)

ADVANCED OPTIONS:
  --max-retries <N>     Maximum retry attempts (default: 3)
  --timeout <N>         Command timeout in seconds (default: 300)
  --log-keep <N>        Keep N recent logs (default: 10)
  --no-stats            Don't show statistics summary

ENVIRONMENT VARIABLES:
  SYSUPDATE_LOG_KEEP    Default log retention count
  SYSUPDATE_KERNELS_KEEP Default kernel retention count
  SYSUPDATE_MAX_RETRIES Default retry count
  SYSUPDATE_TIMEOUT     Default timeout
  SYSUPDATE_VERBOSE     Default verbosity
  SYSUPDATE_SKIP_PIP    Skip pip updates (default: 1 on Ubuntu 23.10+)

EXAMPLES:
  update                     # Update everything
  update --dry-run          # Preview what would be updated
  update --system           # Update system packages only
  update --only apt,flatpak # Update only APT and Flatpak
  update --exclude snap     # Update everything except Snap
  update --security-only    # Security updates only
  update --cleanup          # Update and clean up

LOGS:
  Logs are saved to: ~/.local/state/sysupdate/logs/
  View latest: tail -f ~/.local/state/sysupdate/logs/sysupdate-*.log

NOTE: pip updates are disabled by default on Ubuntu 23.10+ due to PEP 668.
      Use pipx for Python applications instead.

HELP
        return 0
        ;;

      --) shift; break ;;
      *) error "Unknown option: $1"; return 2 ;;
    esac
    shift
  done

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Pre-flight Checks
  # ─────────────────────────────────────────────────────────────────────────────────────────────

  # Initialize logging
  log_init

  # Check OS
  if [[ -f /etc/os-release ]]; then
    local os_id="$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')"
    local os_name="$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')"
    if [[ "$os_id" != "ubuntu" ]] && (( ! force )); then
      warn "This script is optimized for Ubuntu. Detected: $os_name"
      info "Use --force to run anyway"
      update__cleanup
      return 1
    fi
  fi

  # Check for sudo/root
  local sudo=''
  if (( EUID != 0 )); then
    if command -v sudo >/dev/null 2>&1; then
      sudo='sudo'
      if (( ! dryrun )); then
        msg "Requesting administrative privileges..."
        $sudo -v || { error "Failed to obtain sudo privileges"; return 1; }
        # Keep sudo alive
        ( while true; do $sudo -v; sleep 50; done ) &
        local sudo_pid=$!
      fi
    else
      error "Root privileges required. Install sudo or run as root."
      update__cleanup
      return 1
    fi
  fi

  # Environment setup
  export PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"
  local -a envv=(DEBIAN_FRONTEND=noninteractive APT_LISTCHANGES_FRONTEND=none)

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Package Manager Detection
  # ─────────────────────────────────────────────────────────────────────────────────────────────

  local -A available_managers
  local -a active_managers

  detect_managers() {
    # System package managers
    command -v apt-get >/dev/null 2>&1 && available_managers[apt]=1
    command -v snap >/dev/null 2>&1 && [[ -d /run/systemd/system ]] && available_managers[snap]=1
    command -v flatpak >/dev/null 2>&1 && available_managers[flatpak]=1
    command -v brew >/dev/null 2>&1 && available_managers[brew]=1
    command -v nix-env >/dev/null 2>&1 && available_managers[nix]=1

    # Language package managers
    # Skip pip on modern Ubuntu (PEP 668)
    if [[ "${SYSUPDATE_SKIP_PIP:-1}" != "1" ]]; then
      if [[ -f /etc/os-release ]]; then
        local ubuntu_version=$(grep VERSION_ID /etc/os-release | cut -d'"' -f2)
        local major_version="${ubuntu_version%%.*}"
        local minor_version="${ubuntu_version#*.}"
        # Skip on Ubuntu 23.10+
        if [[ "$major_version" -lt 23 ]] || ([[ "$major_version" -eq 23 ]] && [[ "${minor_version%%.*}" -lt 10 ]]); then
          command -v pip3 >/dev/null 2>&1 && available_managers[pip]=1
        fi
      else
        command -v pip3 >/dev/null 2>&1 && available_managers[pip]=1
      fi
    fi

    command -v pipx >/dev/null 2>&1 && available_managers[pipx]=1
    command -v npm >/dev/null 2>&1 && available_managers[npm]=1
    command -v yarn >/dev/null 2>&1 && available_managers[yarn]=1
    command -v pnpm >/dev/null 2>&1 && available_managers[pnpm]=1
    command -v cargo >/dev/null 2>&1 && available_managers[cargo]=1
    command -v rustup >/dev/null 2>&1 && available_managers[rust]=1
    command -v gem >/dev/null 2>&1 && available_managers[gem]=1
    command -v composer >/dev/null 2>&1 && available_managers[composer]=1
    command -v go >/dev/null 2>&1 && available_managers[go]=1
    command -v flutter >/dev/null 2>&1 && available_managers[flutter]=1

    # Development tools
    command -v docker >/dev/null 2>&1 && available_managers[docker]=1
    command -v podman >/dev/null 2>&1 && available_managers[podman]=1
    command -v conda >/dev/null 2>&1 && available_managers[conda]=1
    command -v mamba >/dev/null 2>&1 && available_managers[mamba]=1
    command -v asdf >/dev/null 2>&1 && available_managers[asdf]=1
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && available_managers[sdkman]=1

    # Shell frameworks
    [[ -d "${ZSH:-$HOME/.oh-my-zsh}" ]] && available_managers[ohmyzsh]=1
    command -v antigen >/dev/null 2>&1 && available_managers[antigen]=1
    [[ -d "${ZINIT_HOME:-$HOME/.zinit}" ]] && available_managers[zinit]=1

    # Firmware
    command -v fwupdmgr >/dev/null 2>&1 && available_managers[firmware]=1

    # PlatformIO
    [[ -x "$HOME/platformio-env/bin/pio" ]] && available_managers[platformio]=1

    # Apply scope filters
    case "$scope" in
      system)
        for mgr in apt snap flatpak brew nix firmware; do
          [[ -n "${available_managers[$mgr]:-}" ]] && active_managers+=($mgr)
        done
        ;;
      dev)
        for mgr in docker podman conda mamba asdf sdkman platformio; do
          [[ -n "${available_managers[$mgr]:-}" ]] && active_managers+=($mgr)
        done
        ;;
      lang)
        for mgr in pip pipx npm yarn pnpm cargo rust gem composer go flutter; do
          [[ -n "${available_managers[$mgr]:-}" ]] && active_managers+=($mgr)
        done
        ;;
      frameworks)
        for mgr in ohmyzsh antigen zinit; do
          [[ -n "${available_managers[$mgr]:-}" ]] && active_managers+=($mgr)
        done
        ;;
      all|*)
        active_managers=(${(k)available_managers})
        ;;
    esac

    # Apply include/exclude filters
    if (( ${#include_managers} > 0 )); then
      local -a filtered=()
      for mgr in "${include_managers[@]}"; do
        [[ -n "${available_managers[$mgr]:-}" ]] && filtered+=($mgr)
      done
      active_managers=("${filtered[@]}")
    fi

    if (( ${#exclude_managers} > 0 )); then
      for mgr in "${exclude_managers[@]}"; do
        active_managers=("${active_managers[@]/$mgr}")
      done
    fi
  }

  detect_managers

  if (( ${#active_managers} == 0 )); then
    warn "No package managers found or selected"
    update__cleanup
    return 0
  fi

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Statistics Tracking
  # ─────────────────────────────────────────────────────────────────────────────────────────────

  local -A stats=(
    [start_time]="$(date +%s)"
    [updated_packages]=0
    [errors]=0
    [warnings]=0
  )

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Update Functions
  # ─────────────────────────────────────────────────────────────────────────────────────────────

  update_apt() {
    section "APT Package Manager"

    # Wait for APT locks
    local -a locks=(/var/lib/dpkg/lock-frontend /var/lib/dpkg/lock /var/lib/apt/lists/lock)
    local -i tries=30
    spinner_start "Waiting for APT locks"
    while (( tries > 0 )); do
      if $sudo fuser "${locks[@]}" >/dev/null 2>&1 || pgrep -x "(apt|apt-get|dpkg|unattended-upgrade)" >/dev/null 2>&1; then
        sleep 2
        ((tries--))
      else
        break
      fi
    done
    spinner_stop

    if (( tries == 0 )); then
      error "Timed out waiting for APT locks"
      return 1
    fi

    # Update package lists
    msg "Updating package lists..."
    if (( dryrun )); then
      info "[DRY-RUN] Would execute: $sudo apt-get update"
    else
      local apt_update_output
      apt_update_output=$($sudo env "${envv[@]}" apt-get update -o Acquire::Retries=3 2>&1)
      echo "$apt_update_output" | grep -v "^\(Hit\|Get\|Fetched\|Reading\)"

      # Check for duplicate sources
      if echo "$apt_update_output" | grep -q "is configured multiple times"; then
        warn "Duplicate repository entries detected. Consider cleaning /etc/apt/sources.list.d/"
      fi
    fi

    # Fix broken packages
    if ! $sudo dpkg --audit >/dev/null 2>&1; then
      warn "Broken packages detected, attempting to fix..."
      (( dryrun )) || $sudo env "${envv[@]}" apt-get -f install -y
    fi

    # Security updates only
    if (( security_only )); then
      msg "Installing security updates only..."
      if command -v unattended-upgrade >/dev/null 2>&1; then
        (( dryrun )) || $sudo unattended-upgrade -v
      else
        (( dryrun )) || $sudo env "${envv[@]}" apt-get upgrade -y -o Dir::Etc::SourceList=/etc/apt/security.sources.list
      fi
    else
      # Full system upgrade
      local apt_opts="-o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold"
      if (( include_phased )); then
        apt_opts="$apt_opts -o APT::Get::Always-Include-Phased-Updates=true"
      fi

      if (( dryrun )); then
        msg "Simulating system upgrade..."
        $sudo env "${envv[@]}" apt-get -s full-upgrade $apt_opts
      else
        msg "Upgrading system packages..."
        $sudo env "${envv[@]}" apt-get full-upgrade -y $apt_opts
      fi
    fi

    # Cleanup
    if (( cleanup )); then
      msg "Cleaning up APT..."
      (( dryrun )) || $sudo env "${envv[@]}" apt-get autoremove --purge -y
      (( dryrun )) || $sudo env "${envv[@]}" apt-get autoclean -y

      # Clean old kernels
      if command -v purge-old-kernels >/dev/null 2>&1; then
        (( dryrun )) || $sudo purge-old-kernels --keep $KERNELS_KEEP -y
      else
        msg "Cleaning old kernels (keeping $KERNELS_KEEP)..."
        local current_kernel="$(uname -r)"
        local -a kernels=($(dpkg -l 'linux-image-*' 2>/dev/null | grep '^ii' | awk '{print $2}' | grep -v "$current_kernel" | sort -V | head -n -$KERNELS_KEEP))
        if (( ${#kernels} > 0 )); then
          (( dryrun )) || $sudo apt-get remove --purge -y ${kernels[@]}
        fi
      fi
    fi

    success "APT updates completed"
  }

  update_snap() {
    section "Snap Package Manager"

    if (( dryrun )); then
      msg "Checking for snap updates..."
      snap refresh --list 2>/dev/null || info "No snap updates available"
    else
      msg "Updating snap packages..."
      $sudo snap refresh
    fi

    success "Snap updates completed"
  }

  update_flatpak() {
    section "Flatpak Package Manager"

    if (( dryrun )); then
      msg "Checking for flatpak updates..."
      flatpak remote-ls --updates 2>/dev/null || info "No flatpak updates available"
    else
      msg "Updating flatpak packages..."
      flatpak update -y --noninteractive

      if (( cleanup )); then
        msg "Cleaning unused flatpak runtimes..."
        flatpak uninstall --unused -y --noninteractive
      fi
    fi

    success "Flatpak updates completed"
  }

  update_pip() {
    section "Python Package Manager (pip)"

    # Check for PEP 668 restriction
    if python3 -m pip --version >/dev/null 2>&1; then
      # Test if system is externally managed
      if python3 -c "import sys, sysconfig; sys.exit(0 if sysconfig.get_path('purelib').startswith('/usr') else 1)" 2>/dev/null; then
        info "System Python is externally managed (PEP 668)"
        info "Skipping pip updates - use pipx for Python applications"
        return 0
      fi
    fi

    msg "Updating pip..."
    if (( ! dryrun )); then
      # Try user install first
      if ! python3 -m pip install --upgrade pip --user --quiet 2>/dev/null; then
        # If it fails due to PEP 668, skip pip updates
        info "Cannot update pip due to system restrictions. Use pipx instead."
        return 0
      fi

      msg "Updating pip packages..."
      # Get outdated packages safely
      local outdated_json=$(python3 -m pip list --outdated --user --format=json 2>/dev/null || echo "[]")
      if [[ "$outdated_json" != "[]" ]] && [[ -n "$outdated_json" ]]; then
        local -a outdated=()
        while IFS= read -r pkg; do
          [[ -n "$pkg" ]] && outdated+=("$pkg")
        done < <(echo "$outdated_json" | python3 -c "import sys, json; [print(p['name']) for p in json.load(sys.stdin)]" 2>/dev/null)

        if (( ${#outdated[@]} > 0 )); then
          # Update packages one by one
          for pkg in "${outdated[@]}"; do
            python3 -m pip install --upgrade --user "$pkg" --quiet 2>/dev/null || true
          done
        else
          info "All pip packages are up to date"
        fi
      else
        info "All pip packages are up to date"
      fi
    fi

    success "pip updates completed"
  }

  update_pipx() {
    section "Python Application Manager (pipx)"

    if ! command -v pipx >/dev/null 2>&1; then
      info "pipx not installed - skipping"
      return 0
    fi

    if (( dryrun )); then
      msg "Would update pipx packages"
    else
      msg "Ensuring pipx is configured..."
      pipx ensurepath >/dev/null 2>&1 || true

      msg "Updating pipx packages..."
      local pipx_output=$(pipx upgrade-all 2>&1)
      if echo "$pipx_output" | grep -q "No packages upgraded"; then
        info "All pipx packages are up to date"
      else
        echo "$pipx_output" | grep -E "(upgraded|Upgrading)" || true
        success "pipx packages updated"
      fi
    fi

    success "pipx updates completed"
  }

  update_npm() {
    section "Node Package Manager (npm)"

    msg "Updating npm..."
    run_cmd "npm install -g npm@latest --quiet"

    if (( ! dryrun )); then
      msg "Updating global npm packages..."
      run_cmd "npm update -g --quiet"

      if (( cleanup )); then
        msg "Verifying npm cache..."
        run_cmd "npm cache verify"
      fi
    fi

    success "npm updates completed"
  }

  update_rust() {
    section "Rust Toolchain"

    if (( ! dryrun )); then
      msg "Updating rustup..."
      run_cmd "rustup self update"

      msg "Updating rust toolchain..."
      run_cmd "rustup update"

      if command -v cargo-install-update >/dev/null 2>&1; then
        msg "Updating cargo packages..."
        run_cmd "cargo install-update -a"
      fi
    else
      msg "Would update rust toolchain"
    fi

    success "Rust updates completed"
  }

  update_ohmyzsh() {
    section "Oh My Zsh Framework"

    if (( ! dryrun )); then
      msg "Updating Oh My Zsh..."
      if command -v omz >/dev/null 2>&1; then
        run_cmd "omz update --unattended"
      elif [[ -f "$ZSH/tools/upgrade.sh" ]]; then
        run_cmd "env ZSH='$ZSH' sh '$ZSH/tools/upgrade.sh'"
      fi
    else
      msg "Would update Oh My Zsh"
    fi

    success "Oh My Zsh updates completed"
  }

  update_firmware() {
    section "System Firmware"

    if (( ! dryrun )); then
      msg "Refreshing firmware metadata..."
      run_cmd "$sudo fwupdmgr refresh --force"

      msg "Checking for firmware updates..."
      if $sudo fwupdmgr get-updates >/dev/null 2>&1; then
        msg "Installing firmware updates..."
        run_cmd "$sudo fwupdmgr update -y"
      else
        info "No firmware updates available"
      fi
    else
      msg "Checking for firmware updates..."
      $sudo fwupdmgr get-updates 2>/dev/null || info "No firmware updates available"
    fi

    success "Firmware updates completed"
  }

  update_platformio() {
    section "PlatformIO"

    if (( ! dryrun )); then
      msg "Updating PlatformIO..."
      run_cmd "$HOME/platformio-env/bin/python -m pip install -U platformio"

      msg "Updating PlatformIO platforms and libraries..."
      run_cmd "$HOME/platformio-env/bin/pio pkg update --global"
    else
      msg "Would update PlatformIO"
    fi

    success "PlatformIO updates completed"
  }

  update_flutter() {
    section "Flutter SDK"

    if (( ! dryrun )); then
      msg "Updating Flutter..."
      run_cmd "flutter upgrade --force"

      msg "Updating Dart packages..."
      run_cmd "dart pub global upgrade"
    else
      msg "Would update Flutter SDK"
    fi

    success "Flutter updates completed"
  }

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Main Update Execution
  # ─────────────────────────────────────────────────────────────────────────────────────────────

  (( quiet )) || {
    echo "${colors[bold]}${colors[cyan]}╔════════════════════════════════════════════════════════════════╗${colors[reset]}"
    echo "${colors[bold]}${colors[cyan]}║       Ubuntu System Update v${VERSION} - $(date +%Y-%m-%d\ %H:%M:%S)       ║${colors[reset]}"
    echo "${colors[bold]}${colors[cyan]}╚════════════════════════════════════════════════════════════════╝${colors[reset]}"
    echo ""

    if (( dryrun )); then
      echo "${colors[yellow]}${colors[bold]}⚠ DRY RUN MODE - No changes will be made${colors[reset]}"
    fi

    echo "${colors[dim]}Active package managers: ${active_managers[@]}${colors[reset]}"
    echo ""
  }

  # Execute updates for active managers
  for manager in "${active_managers[@]}"; do
    case "$manager" in
      apt) update_apt ;;
      snap) update_snap ;;
      flatpak) update_flatpak ;;
      pip) update_pip ;;
      pipx) update_pipx ;;
      npm) update_npm ;;
      rust) update_rust ;;
      ohmyzsh) update_ohmyzsh ;;
      firmware) update_firmware ;;
      platformio) update_platformio ;;
      flutter) update_flutter ;;
      *)
        (( VERBOSE )) && warn "Handler not implemented for: $manager"
        ;;
    esac
  done

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Post-Update Checks
  # ─────────────────────────────────────────────────────────────────────────────────────────────

  section "System Health Check"

  # Check for reboot requirement
  if [[ -f /var/run/reboot-required ]]; then
    warn "System reboot required!"
    if [[ -f /var/run/reboot-required.pkgs ]]; then
      info "Packages requiring reboot:"
      cat /var/run/reboot-required.pkgs
    fi
  fi

  # Check for failed systemd services
  if command -v systemctl >/dev/null 2>&1 && [[ -d /run/systemd/system ]]; then
    local failed_services=$(systemctl --failed --no-legend 2>/dev/null | wc -l)
    if (( failed_services > 0 )); then
      warn "Failed systemd services detected: $failed_services"
      info "Run 'systemctl --failed' for details"
    fi
  fi

  # ─────────────────────────────────────────────────────────────────────────────────────────────
  # Summary
  # ─────────────────────────────────────────────────────────────────────────────────────────────

  stats[end_time]="$(date +%s)"
  local duration=$((stats[end_time] - stats[start_time]))

  if (( show_stats && ! quiet )); then
    echo ""
    echo "${colors[bold]}${colors[green]}═══ Update Summary ═══${colors[reset]}"
    echo "Duration: $(printf '%02d:%02d:%02d' $((duration/3600)) $((duration%3600/60)) $((duration%60)))"
    echo "Managers updated: ${#active_managers}"

    if (( dryrun )); then
      echo "Mode: ${colors[yellow]}DRY RUN${colors[reset]}"
    fi

    if [[ -n "${LOGFILE:-}" ]] && [[ -f "$LOGFILE" ]]; then
      echo "Log saved to: ${colors[dim]}$LOGFILE${colors[reset]}"
    fi

    echo ""
    success "System update completed successfully!"
  fi
  update__cleanup
  return 0
}

# Convenience aliases
alias update_system='update'
alias up='update'

# ZSH Completions for update function
_update_completion() {
  local -a opts managers
  opts=(
    '-n:Dry run mode'
    '--dry-run:Simulate updates without making changes'
    '-y:Non-interactive mode'
    '--yes:Auto-confirm all prompts'
    '-q:Minimal output'
    '--quiet:Suppress most output'
    '-v:Verbose output'
    '--verbose:Show detailed information'
    '-f:Force operations'
    '--force:Continue even with warnings'
    '-h:Show help'
    '--help:Display usage information'
    '--all:Update everything (default)'
    '--system:System packages only'
    '--dev:Development tools only'
    '--lang:Language ecosystems only'
    '--frameworks:Shell frameworks only'
    '--include-phased:Include phased updates'
    '--security-only:Security updates only'
    '--cleanup:Clean caches and old packages'
    '--no-stats:Skip statistics summary'
  )

  managers=(apt snap flatpak brew nix pipx npm yarn pnpm cargo rust gem composer go flutter docker podman conda mamba asdf sdkman ohmyzsh antigen zinit platformio firmware)

  _arguments -C \
    '(--dry-run -n)'{-n,--dry-run}'[Simulate updates]' \
    '(--yes -y)'{-y,--yes}'[Non-interactive mode]' \
    '(--quiet -q)'{-q,--quiet}'[Minimal output]' \
    '(--verbose -v)'{-v,--verbose}'[Detailed output]' \
    '(--force -f)'{-f,--force}'[Force operations]' \
    '(--help -h)'{-h,--help}'[Show help]' \
    '--all[Update everything]' \
    '--system[System packages only]' \
    '--dev[Development tools only]' \
    '--lang[Language ecosystems only]' \
    '--frameworks[Shell frameworks only]' \
    '--only[Only update specified]:managers:(${managers})' \
    '--exclude[Exclude specified]:managers:(${managers})' \
    '--include-phased[Include phased updates]' \
    '--security-only[Security updates only]' \
    '--cleanup[Clean caches]' \
    '--kernels-keep[Number of kernels to keep]:number:' \
    '--max-retries[Maximum retry attempts]:number:' \
    '--timeout[Command timeout]:seconds:' \
    '--log-keep[Logs to retain]:number:' \
    '--no-stats[Skip summary]'
}

compdef _update_completion update
compdef _update_completion update_system
compdef _update_completion up

## >>> Modern aliases extras >>>
# bat/cat (sem quebrar aliases existentes)
if ! alias cat >/dev/null 2>&1; then
  if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
  elif command -v batcat >/dev/null 2>&1; then
    alias bat='batcat'
    alias cat='bat --paging=never'
  fi
fi

# fd (apenas se não houver fd e existir fdfind)
if ! alias fd >/dev/null 2>&1; then
  if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
  fi
fi
## <<< Modern aliases extras <<<

## >>> Keybindings extras >>>
# history-substring-search com setas ↑/↓ (se o plugin estiver carregado)
if (( $+functions[history-substring-search-up] )); then
  [[ -n ${terminfo[kcuu1]} ]] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
  [[ -n ${terminfo[kcud1]} ]] && bindkey "${terminfo[kcud1]}" history-substring-search-down
fi
## <<< Keybindings extras <<<

# Per-host overrides
if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# Compile on first load to speed up subsequent shells
if [[ ! -f "${ZDOTDIR:-$HOME}/.zshrc.zwc" || "$HOME/.zshrc" -nt "${ZDOTDIR:-$HOME}/.zshrc.zwc" ]]; then
  zcompile -R "${ZDOTDIR:-$HOME}/.zshrc.zwc" "${ZDOTDIR:-$HOME}/.zshrc" 2>/dev/null || true
fi

# Add local Scripts to PATH
export PATH="$HOME/Scripts:$PATH"

# Flutter SDK
export PATH="$HOME/dev/tools/flutter/bin:$PATH"