# for bootstrap
{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [
    pkgs.nix
    pkgs.cacert
  ];

  # Enable experimental features
  shellHook = ''
    export NIX_CONFIG="experimental-features = nix-command flakes"
  '';
}
