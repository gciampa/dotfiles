# ==============================================================================
# History
# ==============================================================================

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY              # Share history across sessions
setopt HIST_IGNORE_ALL_DUPS       # Remove older duplicate entries
setopt HIST_IGNORE_SPACE          # Don't save commands starting with space
setopt HIST_REDUCE_BLANKS         # Remove extra whitespace from commands
setopt HIST_EXPIRE_DUPS_FIRST     # Expire duplicates first when trimming
setopt HIST_FIND_NO_DUPS          # Skip duplicates when searching

# ==============================================================================
# Directory Navigation
# ==============================================================================

setopt AUTOCD                     # Type directory name to cd into it
setopt AUTOPUSHD                  # Auto-push dirs to stack for popd
setopt PUSHDMINUS                 # Swap +/- meaning for directory stack
setopt PUSHDSILENT                # Don't print stack after pushd/popd
setopt PUSHDTOHOME                # pushd with no args goes to ~
setopt CDABLEVARS                 # cd into variable values
DIRSTACKSIZE=5                    # Max size of directory stack

# ==============================================================================
# Globbing & Patterns
# ==============================================================================

setopt EXTENDED_GLOB              # Extended globbing patterns
unsetopt NOMATCH                  # Allow [ or ] without escaping

# ==============================================================================
# Keybindings
# ==============================================================================

bindkey -v                        # Vi mode
export KEYTIMEOUT=1               # Reduce mode switch delay

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# ==============================================================================
# Completions
# ==============================================================================

fpath=(~/.config/zsh/completions /opt/homebrew/share/zsh/site-functions $fpath)

autoload -Uz compinit
if [[ -n ~/.config/zsh/.zcompdump(#qN.mh+24) ]]; then
  compinit -d ~/.config/zsh/.zcompdump
else
  compinit -C
fi

# AWS CLI completion (requires bashcompinit for bash-style completion)
if command -v aws_completer &> /dev/null; then
  autoload bashcompinit && bashcompinit
  complete -C aws_completer aws
fi

# ==============================================================================
# Environment Variables
# ==============================================================================

export VISUAL=nvim
export EDITOR=$VISUAL
export GPG_TTY=$(tty)
export HOMEBREW_NO_ANALYTICS=1
export GOPATH=$HOME/go
export CLICOLOR=1

# ==============================================================================
# PATH
# ==============================================================================

typeset -U PATH
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
PATH="$GOPATH/bin:$PATH"
export PATH

# ==============================================================================
# Tool Initialization
# ==============================================================================

# mise (version manager for Ruby, Node, Go)
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# FZF
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
  export FZF_DEFAULT_COMMAND="rg --files"
  export FZF_DEFAULT_OPTS="--height 40% --layout reverse"
  source "$ZDOTDIR/themes/catppuccin-mocha-fzf.zsh"
fi

# zsh-autosuggestions
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey '^ ' autosuggest-accept
fi

# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# ==============================================================================
# Functions
# ==============================================================================

for func in "$ZDOTDIR"/functions/*; do
  source "$func"
done

# ==============================================================================
# Aliases
# ==============================================================================

# Unix
alias ll="ls -al"
alias l="ls -lGh"
alias ls="ls -G"
alias mkdir="mkdir -p"

# Editor
alias e="$EDITOR"
alias v="$VISUAL"
alias vim="nvim"
alias vi="nvim"

# Navigation
alias ...="cd ../.."
alias ....="cd ../../.."
alias path='echo $PATH | tr -s ":" "\n"'

# Bundler
alias b="bundle"

# Rails
alias migrate="bin/rails db:migrate db:rollback && bin/rails db:migrate db:test:prepare"

# ==============================================================================
# Colored Man Pages (Catppuccin Mocha)
# ==============================================================================

export LESS_TERMCAP_mb=$'\e[1;34m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;35m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;36m'
export LESS_TERMCAP_ue=$'\e[0m'
