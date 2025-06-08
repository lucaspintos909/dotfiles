{ config, pkgs, ... }:

{
  # Script para recargar el layout de teclado
  home.packages = with pkgs; [
    (writeShellScriptBin "reload-keyboard" ''
      #!/bin/bash
      set -e  # Salir si hay error
      
      echo "🔄 Iniciando recarga del layout de teclado..."
      
      # Recargar layout de teclado después de home-manager switch
      export XKB_DEFAULT_LAYOUT="latam"
      export XKB_DEFAULT_OPTIONS="terminate:ctrl_alt_bksp"
      
      # Esperar un momento para que home-manager termine completamente
      sleep 1
      
      # Para X11/Xorg
      if [ -n "$DISPLAY" ]; then
        echo "📺 Detectado X11/Xorg - Configurando layout..."
        ${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout latam -option terminate:ctrl_alt_bksp || {
          echo "❌ Error configurando X11"
        }
      fi
      
      # Para Wayland/GNOME
      if [ "$XDG_SESSION_TYPE" = "wayland" ] || [ -n "$WAYLAND_DISPLAY" ]; then
        echo "🌊 Detectado Wayland/GNOME - Configurando layout..."
        
        # Configurar usando dconf
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'latam')]" || {
          echo "❌ Error escribiendo sources en dconf"
        }
        
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/input-sources/xkb-options "['terminate:ctrl_alt_bksp']" || {
          echo "❌ Error escribiendo xkb-options en dconf"
        }
        
        # Forzar recarga del layout actual
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/input-sources/current "uint32 0" || {
          echo "❌ Error configurando current en dconf"
        }
        
        # Usar setxkbmap también en Wayland (para aplicaciones X11)
        if command -v setxkbmap >/dev/null 2>&1; then
          ${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout latam -option terminate:ctrl_alt_bksp 2>/dev/null || {
            echo "⚠️  Advertencia: No se pudo configurar setxkbmap"
          }
        fi
        
        # Reiniciar servicios relacionados con el teclado
        systemctl --user restart org.gnome.SettingsDaemon.Keyboard.service 2>/dev/null || {
          echo "⚠️  Advertencia: No se pudo reiniciar servicio de teclado"
        }
        
      else
        echo "❓ Tipo de sesión no detectado, intentando configuración genérica..."
        ${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout latam -option terminate:ctrl_alt_bksp || {
          echo "❌ Error en configuración genérica"
        }
      fi
      
      # Verificar la configuración actual
      echo "🔍 Verificando configuración actual..."
      if command -v setxkbmap >/dev/null 2>&1; then
        ${pkgs.xorg.setxkbmap}/bin/setxkbmap -query 2>/dev/null || echo "⚠️  No se pudo verificar con setxkbmap"
      fi
      
      # Mostrar configuración de dconf
      echo "📋 Configuración actual de GNOME:"
      ${pkgs.dconf}/bin/dconf read /org/gnome/desktop/input-sources/sources 2>/dev/null || echo "⚠️  No se pudo leer sources"
      ${pkgs.dconf}/bin/dconf read /org/gnome/desktop/input-sources/xkb-options 2>/dev/null || echo "⚠️  No se pudo leer xkb-options"
      
      echo "✅ Layout de teclado recargado exitosamente"
    '')
  ];
} 