args @ {pkgs, ...}: {
  imports = [
    (import ../../modules/home-manager/home.nix args)
    (import ../../modules/home-manager/kubernetes-dev.nix args)
    (import ../../modules/home-manager/rust-dev.nix args)
    (import ../../modules/home-manager/writing.nix args)
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/librewolf.nix
    ../../modules/nixos/zathura.nix
  ];
}
