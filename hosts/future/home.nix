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

  xdg.autostart.enable = true;

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

  home.persistence."/persist/home/${args.vars.username}" = {
    allowOther = true;
    directories = [
      "git"
      "syncthing"
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "VirtualBox VMs"
      {
        directory = ".gnupg";
        mode = "0700";
      }
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".local/share/keyrings";
        mode = "0700";
      }
      ".cache/librewolf"
      ".config/syncthing"
      ".librewolf"
      ".local/share/direnv"
    ];
    files = [
      ".config/dconf/user"
      ".local/share/fish/fish_history"
    ];
  };
}
