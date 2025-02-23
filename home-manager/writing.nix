{pkgs, ...}: {
  home.packages = [
    pkgs.pandoc_3_6
    pkgs.proselint
    pkgs.vale
  ];
}
