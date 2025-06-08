{ config, pkgs, ... }:

{
  # Script para recargar el layout de teclado
  home.packages = with pkgs; [
    (writeShellScriptBin "reload-keyboard" ''
      # Recargar layout de teclado después de home-manager switch
      export XKB_DEFAULT_LAYOUT="latam"
      export XKB_DEFAULT_OPTIONS="terminate:ctrl_alt_bksp"
      
      # Para X11/Xorg
      if [ -n "$DISPLAY" ]; then
        ${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout latam -option terminate:ctrl_alt_bksp
      fi
      
      # Para Wayland/GNOME
      if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'latam')]"
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/input-sources/xkb-options "['terminate:ctrl_alt_bksp']"
        
        # Reiniciar el servicio de configuración del teclado de GNOME
        systemctl --user restart gnome-session-manager.service 2>/dev/null || true
      fi
      
      echo "Layout de teclado recargado exitosamente"
    '')
  ];

  # Alias para facilitar el uso
  programs.bash.shellAliases = {
    kb-reload = "reload-keyboard";
  };
} 