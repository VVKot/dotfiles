{pkgs, ...}: {
  home.packages = [
    pkgs.lldb_19
    pkgs.rustup
    pkgs.sccache
  ];

  home.sessionVariables = {
    RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";
    SCCACHE_CACHE_SIZE = "25G";
  };
}
