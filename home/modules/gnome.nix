{ config, pkgs, ... }:

{
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

    # Configuración de entrada
    "org/gnome/desktop/input-sources" = {
      sources = [ [ "xkb" "latam" ] ];
      xkb-options = ["terminate:ctrl_alt_bksp"];
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
        "org.gnome.Console.desktop"
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

  # Paquetes necesarios para las extensiones
  home.packages = with pkgs; [
    gnomeExtensions.system-monitor
    gnomeExtensions.clipboard-indicator
  ];

  # Habilitar extensiones de GNOME
  gtk = {
    enable = true;
  };
}