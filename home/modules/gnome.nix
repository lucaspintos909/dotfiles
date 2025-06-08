{ config, pkgs, ... }:

{
  # Paquetes necesarios para la gestión del teclado
  home.packages = with pkgs; [
    gnomeExtensions.system-monitor
    gnomeExtensions.clipboard-indicator
    xorg.setxkbmap  # Para comandos de teclado
  ];

  # Variables de entorno para el teclado
  home.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "latam";
    XKB_DEFAULT_OPTIONS = "terminate:ctrl_alt_bksp";
  };

  dconf.settings = {
    # Configuración de carpetas de aplicaciones
    "org/gnome/desktop/app-folders" = {
      folder-children = ["Utilities" "YaST" "Pardus"];
    };

    "org/gnome/desktop/app-folders/folders/Pardus" = {
      categories = ["X-Pardus-Apps"];
      name = "X-Pardus-Apps.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [
        "org.freedesktop.GnomeAbrt.desktop"
        "nm-connection-editor.desktop"
        "org.gnome.baobab.desktop"
        "org.gnome.Connections.desktop"
        "org.gnome.DejaDup.desktop"
        "org.gnome.DiskUtility.desktop"
        "org.gnome.Evince.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.font-viewer.desktop"
        "org.gnome.Loupe.desktop"
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.tweaks.desktop"
        "org.gnome.Usage.desktop"
      ];
      categories = ["X-GNOME-Utilities"];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = ["X-SuSE-YaST"];
      name = "suse-yast.directory";
      translate = true;
    };

    # Configuración de fondo y apariencia
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/map-l.svg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/map-d.svg";
      primary-color = "#241f31";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      color-scheme = "prefer-dark";
    };

    # Configuración de entrada - MODIFICADA para mayor persistencia
    "org/gnome/desktop/input-sources" = {
      sources = [ [ "xkb" "latam" ] ];
      xkb-options = ["terminate:ctrl_alt_bksp"];
      # Forzar la aplicación inmediata de los cambios
      current = 0;
      mru-sources = [ [ "xkb" "latam" ] ];
    };

    # Configuración adicional de teclado
    "org/gnome/desktop/peripherals/keyboard" = {
      delay = 500;
      repeat = true;
      repeat-interval = 30;
      numlock-state = true;
    };

    # Configuración del sistema de entrada
    "org/gnome/settings-daemon/plugins/keyboard" = {
      active = true;
    };

    # Notificaciones
    "org/gnome/desktop/notifications" = {
      application-children = [
        "org-gnome-console"
        "brave-browser"
        "gnome-power-panel"
        "org-gnome-nautilus"
        "slack"
        "spotify"
        "discord"
        "org-prismlauncher-prismlauncher"
        "org-gnome-settings"
      ];
    };

    "org/gnome/desktop/notifications/application/brave-browser" = {
      application-id = "brave-browser.desktop";
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-console" = {
      application-id = "org.gnome.Console.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-settings" = {
      application-id = "org.gnome.Settings.desktop";
    };

    "org/gnome/desktop/notifications/application/org-prismlauncher-prismlauncher" = {
      application-id = "org.prismlauncher.PrismLauncher.desktop";
    };

    "org/gnome/desktop/notifications/application/slack" = {
      application-id = "slack.desktop";
    };

    "org/gnome/desktop/notifications/application/spotify" = {
      application-id = "spotify.desktop";
    };

    # Configuración de screensaver
    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/map-l.svg";
      primary-color = "#241f31";
      secondary-color = "#000000";
    };

    # Configuración de energía
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "nothing";
      sleep-inactive-ac-type = "nothing";
    };

    # Configuración de GNOME Shell
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "system-monitor-indicator@mknap.com"
        "clipboard-indicator@tudmotu.com"
      ];
      favorite-apps = [
        "kitty.desktop"
        "brave-browser.desktop"
        "org.gnome.Nautilus.desktop"
        "brave-hnpfjngllnobngcgfapefoaidbinmjnm-Default.desktop"
        "spotify.desktop"
        "cursor.desktop"
        "termius-app.desktop"
        "slack.desktop"
        "discord.desktop"
      ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "47.2";
    };

    # Atajos de teclado
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = ["<Shift><Super>s"];
    };

    # Configuración de Nautilus (Archivos)
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = [ 890 550 ];
      initial-size-file-chooser = [ 890 550 ];
    };
  };

  # Habilitar extensiones de GNOME
  gtk = {
    enable = true;
  };

  # Script de inicio para asegurar el layout de teclado
  systemd.user.services.keyboard-layout-fix = {
    Unit = {
      Description = "Fix keyboard layout after login";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "fix-keyboard-layout" ''
        sleep 2
        export XKB_DEFAULT_LAYOUT="latam"
        export XKB_DEFAULT_OPTIONS="terminate:ctrl_alt_bksp"
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'latam')]"
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/input-sources/xkb-options "['terminate:ctrl_alt_bksp']"
        ${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout latam -option terminate:ctrl_alt_bksp
      ''}";
      RemainAfterExit = true;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}