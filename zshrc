export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export SHELL="$(which zsh)"

export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
eval $(brew shellenv)
autoload -Uz compinit
compinit

# OS-specific setup
case "$OSTYPE" in
  darwin*)
    alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
    alias ls='ls -GpF'
    alias ll='ls -alGpF'
    export ZPLUG_HOME=$(brew --prefix)/opt/zplug
    source $ZPLUG_HOME/init.zsh

    export "JAVA_HOME=$(/usr/libexec/java_home)"
  ;;
  linux*)
    alias ls='ls --color'
    alias ll='ls -laF --color'
    export ZPLUG_HOME=~/.zplug
    source $ZPLUG_HOME/init.zsh
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
esac

zplug "plugins/brew", from:oh-my-zsh, defer:1
zplug "plugins/docker", from:oh-my-zsh, defer:1
zplug "plugins/fzf", from:oh-my-zsh, defer:1
zplug "plugins/gh", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh, defer:1
zplug "plugins/gradle", from:oh-my-zsh, defer:1
zplug "plugins/helm", from:oh-my-zsh, defer:1
zplug "plugins/kind", from:oh-my-zsh, defer:1
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/minikube", from:oh-my-zsh, defer:1
zplug "plugins/terraform", from:oh-my-zsh, defer:1
zplug "plugins/tmux", from:oh-my-zsh, defer:1
zplug "zsh-users/zsh-autosuggestions", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

alias k="kubectl"
alias vi="nvim"
alias vim="nvim"
alias vimdiff='nvim -d'
export VISUAL="nvim"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export KEYTIMEOUT=1 # * 10 ms
bindkey -v
bindkey '\e' vi-cmd-mode
bindkey '^k' autosuggest-execute
bindkey '^y' autosuggest-accept
bindkey '^e' autosuggest-clear

# Bind <C-v> to open command in $EDITOR.
autoload edit-command-line;zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Start with a beam cursor
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# fzf
export FZF_DEFAULT_OPTS="--no-mouse --layout=reverse --color=light,gutter:-1 --cycle
\--bind ctrl-a:select-all,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt share_history

# go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# clangd
export PATH="/usr/local/opt/llvm/bin:$PATH"

if type "rustup" > /dev/null; then
  source <(rustup completions zsh)
fi

if type "sccache" > /dev/null; then
  export RUSTC_WRAPPER=$(which sccache)
fi

grebase() {
  local default=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
  local current=$(git rev-parse --abbrev-ref HEAD)
  echo "==> Checking out $default"
  git checkout $default
  echo ""
  echo "==> Updating $default"
  git pull
  echo ""
  echo "==> Checking back to $current"
  git checkout -
  echo ""
  echo "==> Rebasing $default onto $current"
  git rebase $default $current
  echo "Done!"
}

gmerge() {
  local default=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
  local current=$(git rev-parse --abbrev-ref HEAD)
  echo "==> Checking out $default"
  git checkout $default
  echo ""
  echo "==> Updating $default"
  git pull
  echo ""
  echo "==> Checking back to $current"
  git checkout -
  echo ""
  echo "==> Merging $default into $current"
  git merge $default
  echo "Done!"
}

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f ~/.zshrcextra ]; then
    source ~/.zshrcextra
fi

export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

loadnvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}

# pyenv
if type "pyenv" > /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

export K9S_CONFIG_DIR="$HOME/.config/k9s"
