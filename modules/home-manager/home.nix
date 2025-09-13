{
  config,
  pkgs,
  vars,
  lib,
  ...
}: {
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${vars.username}";
  home.homeDirectory = lib.mkForce "${vars.home}/${vars.username}";

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
    pkgs.nix-your-shell

    # shell
    pkgs.certigo
    pkgs.fd
    pkgs.gawk
    pkgs.gh
    pkgs.git-lfs
    pkgs.graphviz
    pkgs.htop
    pkgs.jq
    pkgs.pnpm
    pkgs.ripgrep
    pkgs.tealdeer
    pkgs.tree
    pkgs.unixtools.watch
    pkgs.wget
    pkgs.xh
    pkgs.yq

    # neovim
    pkgs.lua-language-server
    pkgs.neovim
    pkgs.stylua
    pkgs.tree-sitter

    # pkgs
    pkgs.basedpyright
    pkgs.ruff

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";

    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    VISUAL = "nvim";

    FZF_DEFAULT_OPTS = "--no-mouse --layout=reverse --color=light,gutter:-1 --cycle
\--bind ctrl-a:select-all,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down";

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

      if test -x "${vars.homebrewPrefix}/bin/brew"
        eval (${"${vars.homebrewPrefix}/bin/brew shellenv"})
      end

      nix-your-shell fish | source
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
    initContent = ''
      export KEYTIMEOUT=1 # * 10 ms
      bindkey -v
      bindkey '\e' vi-cmd-mode
      bindkey '^k' autosuggest-execute
      bindkey '^y' autosuggest-accept
      bindkey '^e' autosuggest-clear

      # Bind <C-v> to open command in $EDITOR.
      autoload edit-command-line;zle -N edit-command-line
      bindkey -M vicmd '^v' edit-command-line

      if [ -x "${vars.homebrewPrefix}/bin/brew" ]; then
        eval "$(${vars.homebrewPrefix}/bin/brew shellenv)"
      fi

      nix-your-shell zsh | source /dev/stdin
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

    "$HOME/.krew/bin"

    "$HOMEBREW_PREFIX/bin"
    "$HOMEBREW_PREFIX/sbin"

    "$GOBIN"
    "$CARGO_HOME/bin"
  ];

  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal =
      if pkgs.stdenv.isDarwin
      then "xterm-ghostty"
      else "tmux-256color";
    escapeTime = 50;
    historyLimit = 10000;
    keyMode = "vi";
    prefix = "C-q";
    sensibleOnTop = true;
    baseIndex = 1;
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      extrakto
      {
        plugin = fingers;
        extraConfig = ''
          set -g @fingers-pattern-0 '[a-z0-9]+-[^ ]+'
        '';
      }
      pain-control
      yank
    ];
    extraConfig = builtins.readFile ./tmux-custom.conf;
  };

  home.file.".config" = {
    source = ../../config;
    recursive = true;
  };

  programs.readline.extraConfig = ''
    set editing-mode vi
    set keymap vi
  '';

  # cannot use Ghostty because it is broken on Darwin: https://github.com/NixOS/nixpkgs/issues/388984
  xdg.configFile."ghostty/config".text = ''
    command = "${pkgs.fish}/bin/fish"

    theme = "iTerm2 Light Background"
    font-size = 12
    font-feature = -calt, -liga, -dlig
    macos-option-as-alt = true

    # HACK: CTRL-M = CR, CTRL-I = Tab, CTRL-[ = Esc don't see to work in zsh
    keybind = ctrl+m=text:\x0D
    keybind = ctrl+i=text:\x09
    keybind = ctrl+[=text:\x1B
  '';

  programs.git = {
    enable = true;
    userName = "${vars.git-username}";
    userEmail = "${vars.email}";
    ignores = [".DS_Store"];
    lfs.enable = true;
    extraConfig = {
      core = {
        editor = "nvim";
      };

      column = {
        ui = "auto";
      };

      branch = {
        sort = "-committerdate";
      };

      diff = {
        tool = "nvim -d";
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      merge = {
        tool = "nvim -d";
      };

      git = {
        rebase = true;
      };

      pull = {
        rebase = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      commit = {
        verbose = true;
      };

      help = {
        autocorrect = "prompt";
      };

      tag = {
        sort = "version:refname";
      };

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      checkout = {
        defaultRemote = "origin";
      };

      push = {
        autoSetupRemote = true;
        default = "simple";
        followTags = true;
      };
    };
  };

  programs.vscode = {
    enable = true;

    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          k--kato.intellij-idea-keybindings
          asvetliakov.vscode-neovim
        ];

        userSettings = {
          "workbench.colorTheme" = "Default Light Modern";
          "editor.renderWhitespace" = "all";
          "explorer.confirmDelete" = false;
          "workbench.editor.enablePreview" = false;
          "workbench.editor.enablePreviewFromQuickOpen" = false;
          "vscode-neovim.neovimExecutablePaths.darwin" = "${pkgs.neovim}/bin/nvim";
          "vscode-neovim.neovimExecutablePaths.linux" = "${pkgs.neovim}/bin/nvim";
          "java.semanticHighlighting.enabled" = true;
          "editor.fontFamily" = "JetBrains Mono; Menlo, Monaco, 'Courier New', monospace";
          "npm.packageManager" = "pnpm";
          "eslint.packageManager" = "pnpm";
          "tslint.packageManager" = "pnpm";
          "stylelint.packageManager" = "pnpm";
          "eslint.alwaysShowStatus" = true;
          "terminal.integrated.defaultProfile.linux" = "fish";
          "terminal.integrated.defaultProfile.osx" = "fish";
          "terminal.integrated.shell.linux" = "fish";
          "terminal.integrated.shell.osx" = "fish";
          "editor.inlineSuggest.enabled" = true;
          "extensions.experimental.affinity" = {
            "asvetliakov.vscode-neovim" = 1;
          };
          "editor.fontSize" = 14;
          "telemetry.telemetryLevel" = "off";
        };
      };
    };
  };
}
