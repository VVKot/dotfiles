{
  self,
  config,
  pkgs,
  home-manager,
  lib,
  ...
}: let
  vars = {
    username = "kot";
    home = "/Users";
    git-username = "VVKot";
    email = "volodymyr.kot.ua@gmail.com";
    homebrewPrefix = "/usr/local";
  };
in {
  imports = [
    home-manager.darwinModules.home-manager
  ];
  environment.systemPackages = [pkgs.neovim];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Because I use Determinate System's installer
  nix.enable = false;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  system = {
    primaryUser = "${vars.username}";
    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        tilesize = 64;
        show-recents = false;
        # group windows by application
        expose-group-apps = true;
        mru-spaces = false;
        launchanim = false;
        persistent-apps = [
          {app = "/Applications/Safari.app";}
          {app = "/Applications/Ghostty.app";}
          {app = "/Applications/Amazon Kindle.app";}
          {app = "/Applications/Obsidian.app";}
          {app = "/System/Applications/Notes.app";}
          {app = "/System/Applications/Reminders.app";}
          {app = "/System/Applications/Messages.app";}
        ];
      };
      finder = {
        AppleShowAllExtensions = true;
        # current folder
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        ShowPathbar = true;
      };
      NSGlobalDomain = {
        "com.apple.keyboard.fnState" = true;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowShouldDragOnGesture = true;
      };
      CustomUserPreferences = {
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          ScheduleFrequency = 1;
          AutomaticDownload = 1;
          CriticalUpdateInstall = 1;
        };
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  homebrew = {
    enable = true;

    taps = [];
    brews = [];
    casks = [];
  };

  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
  };

  fonts.packages = [
    pkgs.jetbrains-mono
  ];

  users.users.${vars.username} = {
    name = "${vars.username}";
    home = "${vars.home}/${vars.username}";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${vars.username} = import ./home.nix {
    inherit config pkgs lib vars;
  };
}
