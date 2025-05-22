{ config, pkgs, ... }:

{
  config = {
    # Enable dconf
    programs.dconf.enable = true;

    # GNOME Desktop Environment
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.displayManager.gdm.enable = true;

    # GNOME Settings
    dconf.settings = {
      # Power Management
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
      };

      # Desktop Interface
      "org/gnome/desktop/interface" = {
        # Clock settings
        clock-format = "24h";
        clock-show-date = true;
        clock-show-seconds = false;
        clock-show-weekday = false;
        
        # Theme and appearance
        color-scheme = "prefer-dark";
        accent-color = "teal";
        gtk-theme = "Adwaita";
        icon-theme = "Adwaita";
        cursor-theme = "Adwaita";
        
        # Font settings
        font-name = "Cantarell 11";
        document-font-name = "Cantarell 11";
        monospace-font-name = "Source Code Pro 10";
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        font-rendering = "automatic";
        font-rgba-order = "rgb";
        
        # Interface behavior
        enable-hot-corners = true;
        enable-animations = true;
        show-battery-percentage = false;
        locate-pointer = false;
        overlay-scrolling = true;
        
        # GTK settings
        gtk-enable-primary-paste = true;
        gtk-timeout-initial = 200;
        gtk-timeout-repeat = 20;
        gtk-key-theme = "Default";
        
        # Menu and toolbar settings
        menubar-accel = "F10";
        menubar-detachable = false;
        menus-have-tearoff = false;
        toolbar-detachable = false;
        toolbar-icons-size = "large";
        toolbar-style = "both-horiz";
        
        # Accessibility
        toolkit-accessibility = false;
        
        # Scaling
        scaling-factor = 0;
        text-scaling-factor = 1.0;
      };

      # Session Settings
      "org/gnome/desktop/session" = {
        idle-delay = 0;
      };

      # Privacy Settings
      "org/gnome/desktop/privacy" = {
        report-technical-problems = false;
        remember-recent-files = false;
      };

      # Background Settings
      "org/gnome/desktop/background" = {
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-l.jpg";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.jpg";
      };

      # Workspace Settings
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        workspaces-only-on-primary = true;
      };

      # Keyboard Settings
      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = ["<Super>Tab"];
        switch-applications-backward = ["<Super><Shift>Tab"];
        switch-windows = ["<Alt>Tab"];
        switch-windows-backward = ["<Alt><Shift>Tab"];
      };
    };

    # Disable auto-suspend
    services.xserver.displayManager.gdm.autoSuspend = false;

    # Systemd sleep settings
    systemd.sleep = {
      extraConfig = ''
        AllowSuspend=no
        AllowHibernation=no
        AllowHybridSleep=no
        AllowSuspendThenHibernate=no
      '';
    };
  };
} 