args @ {pkgs, ...}: {
  services.pass-secret-service.enable = true;

  programs.keepassxc = {
    enable = true;
  };
}
