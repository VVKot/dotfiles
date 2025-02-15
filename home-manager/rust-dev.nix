{pkgs, ...}: {
  home.packages = [
    pkgs.sccache
    pkgs.rust-analyzer
  ];
}
