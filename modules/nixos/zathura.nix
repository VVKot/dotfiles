args @ {pkgs, ...}: {
  programs.zathura = {
    enable = true;
    options = {
      synctex = true;
    };
    extraConfig = ''
      nvim --headless -c "VimtexInverseSearch %l '%f'"
    '';
  };
}
