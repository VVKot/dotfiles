args @ {...}: {
  imports = [
    (import ../../modules/home-manager/home.nix args)
    (import ../../modules/home-manager/kubernetes-dev.nix args)
    (import ../../modules/home-manager/rust-dev.nix args)
  ];

  programs.librewolf.enable = true;
}
