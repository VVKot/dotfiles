# Best-effort translation of home-manager-generated config for non-Nix systems

set -gx CARGO_HOME "$HOME"'/.cargo'
set -gx EDITOR 'nvim'
set -gx FZF_DEFAULT_OPTS '--no-mouse --layout=reverse --color=light,gutter:-1 --cycle
--bind ctrl-a:select-all,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
set -gx GOBIN "$GOPATH"'/bin'
set -gx GOPATH "$HOME"'/go'
set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL 'en_US.UTF-8'
set -gx MANPAGER 'nvim +Man!'
set -gx VISUAL 'nvim'
set -gx XDG_CACHE_HOME '~/.cache'
set -gx XDG_CONFIG_HOME '~/.config'
set -gx XDG_DATA_HOME '~/.local/share'
set -gx XDG_STATE_HOME '~/.local/state'
set -gx PATH "$PATH"(test -n "$PATH" && echo ':' || echo)'/nix/var/nix/profiles/default/bin:'"$HOME"'/.nix-profile/bin:'"$HOMEBREW_PREFIX"'/bin:'"$HOMEBREW_PREFIX"'/sbin:'"$GOBIN"':'"$CARGO_HOME"'/bin'

/home/linuxbrew/.linuxbrew/bin/brew shellenv | source

status is-login; and begin

    # Login shell initialisation


end

status is-interactive; and begin

    # Abbreviations


    # Aliases
    alias k kubectl
    alias vi nvim
    alias vim nvim

    # Interactive shell initialisation
    fzf --fish | source

    set fish_greeting # Disable greeting

    fish_vi_key_bindings
    fish_vi_cursor
    bind \cy accept-autosuggestion
    bind --mode insert \cy accept-autosuggestion
    bind \ck accept-autosuggestion execute
    bind --mode insert \ck accept-autosuggestion execute

    if test "$TERM" != dumb
        starship init fish | source
    end

end
