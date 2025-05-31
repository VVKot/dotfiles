{
  config,
  pkgs,
  vars,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${vars.username}";
  home.homeDirectory = "${vars.home}/${vars.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Enable XDG directory management
  xdg.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # nix
    pkgs.alejandra
    pkgs.cacert
    pkgs.nil

    # shell
    pkgs.certigo
    pkgs.fd
    pkgs.fish
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.git-lfs
    pkgs.graphviz
    pkgs.htop
    pkgs.jq
    pkgs.ripgrep
    pkgs.starship
    pkgs.tealdeer
    pkgs.tmux
    pkgs.tree
    pkgs.unixtools.watch
    pkgs.wget
    pkgs.yq

    # neovim
    pkgs.lua-language-server
    pkgs.neovim
    pkgs.stylua

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kot/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";

    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    VISUAL = "nvim";

    FZF_DEFAULT_OPTS = "--no-mouse --layout=reverse --color=light,gutter:-1 --cycle
\--bind ctrl-a:select-all,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down";

    GOPATH = "$HOME/go";
    GOBIN = "$GOPATH/bin";

    CARGO_HOME = "$HOME/.cargo";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      fish_vi_key_bindings
      fish_vi_cursor
      bind \cy accept-autosuggestion
      bind --mode insert \cy accept-autosuggestion
      bind \ck accept-autosuggestion execute
      bind --mode insert \ck accept-autosuggestion execute

      brew shellenv | source
    '';
    shellAliases = {
      vi = "nvim";
      vim = "nvim";

      k = "kubectl";
    };
    functions = {
      flushdns = "sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder";
    };
  };

  home.shell.enableFishIntegration = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      append = true;
      ignoreAllDups = true;
    };
    initExtra = ''
      export KEYTIMEOUT=1 # * 10 ms
      bindkey -v
      bindkey '\e' vi-cmd-mode
      bindkey '^k' autosuggest-execute
      bindkey '^y' autosuggest-accept
      bindkey '^e' autosuggest-clear

      # Bind <C-v> to open command in $EDITOR.
      autoload edit-command-line;zle -N edit-command-line
      bindkey -M vicmd '^v' edit-command-line

      eval $(brew shellenv)
    '';
    shellAliases = {
      vi = "nvim";
      vim = "nvim";

      k = "kubectl";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  home.sessionPath = [
    "/nix/var/nix/profiles/default/bin"
    "$HOME/.nix-profile/bin"

    "$HOMEBREW_PREFIX/bin"
    "$HOMEBREW_PREFIX/sbin"

    "$GOBIN"
    "$CARGO_HOME/bin"
  ];

  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    escapeTime = 50;
    historyLimit = 10000;
    keyMode = "vi";
    prefix = "C-q";
    sensibleOnTop = true;
    baseIndex = 1;
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      extrakto
      pain-control
      yank
    ];
    extraConfig = builtins.readFile ./tmux-custom.conf;
  };

  home.file.".config" = {
    source = ../config;
    recursive = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
