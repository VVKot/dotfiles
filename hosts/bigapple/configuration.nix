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
