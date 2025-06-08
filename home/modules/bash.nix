{
  programs.bash = {
    enable = true;
    
    # Funciones personalizadas
    bashrcExtra = ''
      # Función para recargar el layout de teclado
      reload_keyboard() {
        echo "🔄 Recargando layout de teclado..."
        sleep 1
        
        # Configurar setxkbmap
        if command -v setxkbmap >/dev/null 2>&1; then
          setxkbmap -layout latam -option terminate:ctrl_alt_bksp && echo "✓ setxkbmap configurado"
        else
          echo "⚠️  setxkbmap no disponible"
        fi
        
        # Configurar GNOME via dconf
        if command -v dconf >/dev/null 2>&1; then
          dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'latam')]" && echo "✓ GNOME sources configurado"
          dconf write /org/gnome/desktop/input-sources/xkb-options "['terminate:ctrl_alt_bksp']" && echo "✓ GNOME options configurado"  
          dconf write /org/gnome/desktop/input-sources/current 'uint32 0' && echo "✓ GNOME current configurado"
        else
          echo "⚠️  dconf no disponible"
        fi
        
        echo "✅ Layout de teclado recargado"
      }
      
      
      # Función para verificar configuración del teclado
      kb_check() {
        echo "🔍 Verificando configuración del teclado..."
        echo "📋 Configuración setxkbmap:"
        if command -v setxkbmap >/dev/null 2>&1; then
          setxkbmap -query 2>/dev/null || echo "⚠️  No se pudo verificar con setxkbmap"
        else
          echo "⚠️  setxkbmap no disponible"
        fi
        
        echo "📋 Configuración GNOME:"
        if command -v dconf >/dev/null 2>&1; then
          echo "Sources: $(dconf read /org/gnome/desktop/input-sources/sources 2>/dev/null || echo 'No disponible')"
          echo "Options: $(dconf read /org/gnome/desktop/input-sources/xkb-options 2>/dev/null || echo 'No disponible')"
        else
          echo "⚠️  dconf no disponible"
        fi
      }
    '';
    
    shellAliases = 
    let 
        flakePath = "~/nix";
    in {
      rebuild = "sudo nixos-rebuild switch --flake ${flakePath}";
      hms = "home-manager switch --flake ${flakePath} && echo '🔄 Recargando layout de teclado...' && sleep 1 && setxkbmap -layout latam -option terminate:ctrl_alt_bksp && dconf write /org/gnome/desktop/input-sources/sources \"[('xkb', 'latam')]\" && dconf write /org/gnome/desktop/input-sources/xkb-options \"['terminate:ctrl_alt_bksp']\" && dconf write /org/gnome/desktop/input-sources/current 'uint32 0' && echo '✅ Layout recargado'";
      kb-reload = "reload_keyboard";  # Función independiente
      kb-check = "kb_check";  # Función de verificación
      vim = "nvim";
      vi = "nvim";
      la = "ls -la";
      l = "ls -la";
    };
  };
}
