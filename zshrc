export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export EDITOR="vim"
bindkey '\e' vi-cmd-mode
export KEYTIMEOUT=1 # * 10 ms

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
