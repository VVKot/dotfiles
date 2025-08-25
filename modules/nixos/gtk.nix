{...}: {
  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-decoration-layout = "icon:minimize,maximize,close";
      gtk-key-theme-name = "Emacs";
    };
  };
}
