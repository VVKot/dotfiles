{pkgs, ...}: {
  home.packages = with pkgs; [
    dconf-editor
    gnome-tweaks
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
  ];

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["caps:ctrl_modifier"];
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "caffeine@patapon.info"
        "gsconnect@andyholmes.github.io"
        "just-perfection-desktop@just-perfection"
      ];
      favorite-apps = [
        "librewolf.desktop"
        "com.mitchellh.ghostty.desktop"
        "obsidian.desktop"
        "spotify.desktop"
      ];
      # make sure bluetooth icon is always present
      had-bluetooth-devices-setup = true;
      # remove welcome tour
      welcome-dialog-last-shown-version = "42.4";
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      enable-hot-corners = false;
      enable-animations = false;
    };
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [];
      toggle-message-tray = [];
      close = ["<Super>q"];
      move-to-monitor-down = [];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-monitor-up = [];
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      move-to-workspace-5 = ["<Shift><Super>5"];
      move-to-workspace-6 = ["<Shift><Super>6"];
      move-to-workspace-7 = ["<Shift><Super>7"];
      move-to-workspace-8 = ["<Shift><Super>8"];
      move-to-workspace-9 = ["<Shift><Super>9"];
      move-to-workspace-down = ["disabled"];
      move-to-workspace-up = ["disabled"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-input-source = [];
      switch-input-source-backward = [];
      toggle-maximized = ["<Super>f"];
      minimize = [];
      maximize = [];
      unmaximize = [];
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 9;
    };
    "org/gnome/shell/extensions/just-perfection" = {
      workspace-popup = false;
    };
    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      natural-scroll = true;
      scroll-factor = 1.2;
    };
    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [];
      terminal = [];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "terminal super";
      command = "ghostty";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
    };
  };
}
