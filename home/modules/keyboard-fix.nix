{ config, lib, pkgs, ... }:

{
  # Script con substituciones de Nix
  home.file.".local/bin/keyboard-reload".source = pkgs.replaceVars ../scripts/keyboard-reload.sh {
    setxkbmap = "${pkgs.xorg.setxkbmap}/bin/setxkbmap";
    dconf = "${pkgs.dconf}/bin/dconf";
  };

  # Hacer el script ejecutable
  home.file.".local/bin/keyboard-reload".executable = true;

  # Hook de activación - se ejecuta automáticamente después de home-manager switch
  home.activation.reloadKeyboard = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "🔄 Ejecutando recarga automática del layout de teclado..."
    if [[ -x "$HOME/.local/bin/keyboard-reload" ]]; then
      # Exportar variables de entorno necesarias
      export DISPLAY="${config.home.sessionVariables.DISPLAY or ":0"}"
      export XDG_SESSION_TYPE="${config.home.sessionVariables.XDG_SESSION_TYPE or "wayland"}"
      export WAYLAND_DISPLAY="${config.home.sessionVariables.WAYLAND_DISPLAY or "wayland-0"}"
      
      $DRY_RUN_CMD "$HOME/.local/bin/keyboard-reload"
    else
      echo "⚠️  Script de recarga no encontrado"
    fi
  '';

  # Añadir ~/.local/bin al PATH para acceso fácil al script
  home.sessionPath = [ "$HOME/.local/bin" ];

  # Alias opcional para uso manual
  programs.bash.shellAliases = {
    kb-reload = "$HOME/.local/bin/keyboard-reload";
  };
} 