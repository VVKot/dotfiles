args @ {...}: {
  imports = [
    (import ../../modules/home-manager/home.nix args)
  ];
}
