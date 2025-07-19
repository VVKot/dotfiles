{pkgs, ...}: {
  home.packages = [
    pkgs.languagetool
    pkgs.pandoc
    pkgs.proselint
    pkgs.vale
  ];
}
