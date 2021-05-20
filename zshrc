export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# OS-specific setup
case "$OSTYPE" in
  darwin*)
    alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
    alias ls='ls -GpF'
    alias ll='ls -alGpF'
  ;;
  linux*)
    alias ls='ls --color'
    alias ll='ls -laF --color'
esac

export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/gradle", from:oh-my-zsh
zplug "plugins/yarn", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

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
export FZF_DEFAULT_OPTS="--layout=reverse --bind ctrl-a:select-all --color=light"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

# nvm
export NVM_DIR="$HOME/.nvm"
alias loadnvm='[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"'

export NODE_OPTIONS=--max_old_space_size=8192

# for pnpm completion
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# clangd
export PATH="/usr/local/opt/llvm/bin:$PATH"

# do not apply pre-commit hooks by default
export HUSKY_SKIP_HOOKS=1

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

dadjoke() {
  curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke'
}
