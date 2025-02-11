

# ~~~~~~~~~~~~~~~ Editing Mode ~~~~~~~~~~~~~~~~~~~~~~~~
set -o vi
export VISUAL=nvim
export EDITOR=nvim
export TERM="tmux-256color"
export BROWSER="firefox"

# ~~~~~~~~~~~~~~~ Directories ~~~~~~~~~~~~~~~~~~~~~~~~
export REPOS="$HOME/Repos"
export GITUSER="japostadan"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export ICLOUD="$HOME/icloud"
export ZETTELKASTEN="$HOME/Ikigai"


setopt extended_glob null_glob

path=(
    $path                           # Keep existing PATH entries
    $HOME/bin
    $HOME/.local/bin
    $SCRIPTS
    $HOME/.krew/bin
    $HOME/.rd/bin                   # Rancher Desktop
    /home/vscode/.local/bin         # Dev Container Specifics
    /root/.local/bin                # Dev Container Specifics
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

# ~~~~~~~~~~~~~~~ Dev Container Specifics ~~~~~~~~~~~~~~~~~~~~~~~~
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~
PURE_GIT_PULL=0

if [[ "$OSTYPE" == darwin* ]]; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
else
  fpath+=($HOME/.zsh/pure)
fi

autoload -U promptinit; promptinit
prompt pure

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~
# neovim

alias v=nvim

# tmux integration
alias t='tmux'
alias ta='tmux attach'
alias tls='tmux list-sessions'
alias tn='tmux new-session'

# Reload tmux config to match .tmux.conf
alias reload-tmux='tmux source-file ~/.tmux.conf'

# Navigation
alias scripts='cd $SCRIPTS'
alias icloud="cd \$ICLOUD"
alias lab='cd $LAB'
alias dot='cd $GHREPOS/dotfiles'
alias ghrepos='cd $GHREPOS'
alias gr='ghrepos'
alias cdzk="cd \$ZETTELKASTEN"


# ls
alias ls='ls --color=auto'
alias la='ls -lathr'

# Find files sorted by modification
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

# Clear screen
alias c='clear'
alias e='exit'

# Git
alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gcl='git clone --revursive-submodules'
alias gcm='git commit --all --message'
alias glog='git log --oneline --decorate --graph --all'

alias lg='lazygit'

# Zettelkasten

alias in="cd \$ZETTELKASTEN/inbox/"
alias cdzk="cd \$ZETTELKASTEN"

# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'
alias fgk='flux get kustomizations'


# Reload Zsh config
alias reload='source ~/.zshrc'

# Devpod

alias ds='devpod ssh'

# Bluetooth

# Sony Headest
alias btm='bluetoothctl connect 40:72:18:32:AC:53'


# ~~~~~~~~~~~~~~~ Completion ~~~~~~~~~~~~~~~~~~~~~~~~
fpath+=~/.zfunc

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select

# ~~~~~~~~~~~~~~~ Misc Enhancements ~~~~~~~~~~~~~~~~~~~~~~~~
# Add tmux integration for Vi-style pane navigation in shell
bindkey '^k' up-line-or-history
bindkey '^j' down-line-or-history

