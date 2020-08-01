export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/gradle", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

export EDITOR="vim"
export KEYTIMEOUT=1 # * 10 ms
bindkey -v
bindkey '\e' vi-cmd-mode
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

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias ls='ls -GpF'
alias ll='ls -alGpF'
