export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export SHELL="$(which zsh)"

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
esac

zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/gh", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/gradle", from:oh-my-zsh
zplug "plugins/helm", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/minikube", from:oh-my-zsh
zplug "plugins/terraform", from:oh-my-zsh
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
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

# go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# clangd
export PATH="/usr/local/opt/llvm/bin:$PATH"

# kubectl
if type "kubectl" > /dev/null; then
  source <(kubectl completion zsh)
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

# mimic bash
export PS1="[%n@%m %1~]\$ "

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f ~/.zshrcextra ]; then
    source ~/.zshrcextra
fi

export WASMTIME_HOME="$HOME/.wasmtime"
export CARGO_HOME="$HOME/.cargo"

export PATH="$WASMTIME_HOME/bin:$CARGO_HOME/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

loadnvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}
