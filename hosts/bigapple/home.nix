args @ {...}: {
  imports = [
    (import ../../modules/home-manager/home.nix args)
    (import ../../modules/home-manager/writing.nix args)
  ];
}
