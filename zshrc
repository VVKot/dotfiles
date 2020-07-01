bindkey '\e' vi-cmd-mode
export KEYTIMEOUT=1 # * 10 ms

HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
