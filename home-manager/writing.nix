{pkgs, ...}: {
  home.packages = [
    pkgs.languagetool
    pkgs.pandoc_3_6
    pkgs.proselint
    pkgs.vale
    pkgs.write-good
  ];
}
