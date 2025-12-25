args @ {pkgs, ...}: {
  imports = [
    (import ../../modules/home-manager/home.nix args)
    (import ../../modules/home-manager/kubernetes-dev.nix args)
    (import ../../modules/home-manager/rust-dev.nix args)
    (import ../../modules/home-manager/writing.nix args)
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/gtk.nix
    ../../modules/nixos/keypass.nix
    ../../modules/nixos/librewolf.nix
    ../../modules/nixos/rust-rover.nix
    ../../modules/nixos/media.nix
    ../../modules/nixos/zathura.nix
  ];

  programs.git = {
    settings = {
      sendemail = {
        smtpServer = "smtp.gmail.com";
        smtpUser = "${args.vars.email}";
        smtpServerPort = 587;
        smtpEncryption = "tls";
      };

      credential = {
        helper = "cache --timeout 3600";
      };
    };
  };
}
