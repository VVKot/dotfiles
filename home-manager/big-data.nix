{pkgs, ...}: {
  home.packages = [
    pkgs.spark
    pkgs.parquet-tools
  ];
}
