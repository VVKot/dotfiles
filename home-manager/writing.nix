{pkgs, ...}: {
  home.packages = [
    pkgs.pandoc
    pkgs.proselint
    pkgs.vale
  ];
}
