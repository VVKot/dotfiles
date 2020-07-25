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
bindkey '\e' vi-cmd-mode
export KEYTIMEOUT=1 # * 10 ms

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

