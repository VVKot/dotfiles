{pkgs, ...}: {
  home.packages = [
    pkgs.lldb_19
    pkgs.rustup
    pkgs.sccache
  ];
}
