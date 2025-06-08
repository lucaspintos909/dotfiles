#!/usr/bin/env bash

# Script para configurar Powerlevel10k en Home Manager
# Problema: .zshrc es de solo lectura en Home Manager
# Solución: Usar archivos temporales y copiar la configuración a un archivo personalizado

set -euo pipefail

echo "🔧 Configurador de Powerlevel10k para Home Manager"
echo "=================================================="

# Crear directorio temporal
TEMP_DIR=$(mktemp -d)
TEMP_ZSHRC="$TEMP_DIR/.zshrc"
CONFIG_DIR="$HOME/.config/zsh"
P10K_CUSTOM_CONFIG="$CONFIG_DIR/p10k-custom.zsh"

# Crear directorio de configuración si no existe
mkdir -p "$CONFIG_DIR"

echo "📁 Creando .zshrc temporal en: $TEMP_DIR"

# Crear un .zshrc temporal básico para que p10k configure pueda trabajar
cat > "$TEMP_ZSHRC" << 'EOF'
# Configuración temporal para Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Cargar Powerlevel10k
source /nix/store/*/share/zsh-powerlevel10k/powerlevel10k.zsh-theme 2>/dev/null || {
  echo "Buscando Powerlevel10k..."
  P10K_PATH=$(find /nix/store -name "powerlevel10k.zsh-theme" -path "*/share/zsh-powerlevel10k/*" 2>/dev/null | head -1)
  if [[ -n "$P10K_PATH" ]]; then
    source "$P10K_PATH"
  else
    echo "Error: No se encontró Powerlevel10k"
    exit 1
  fi
}

# Configuración será agregada aquí por p10k configure
EOF

echo "🚀 Ejecutando configurador de Powerlevel10k..."
echo "   - Usa las flechas para navegar"
echo "   - Presiona 'y' para Sí, 'n' para No"
echo "   - Al final, elige 'y' para aplicar cambios"
echo ""

# Cambiar a directorio temporal y ejecutar configurador
cd "$TEMP_DIR"
ZDOTDIR="$TEMP_DIR" zsh -c "
export ZDOTDIR='$TEMP_DIR'
export HOME='$TEMP_DIR'
source '$TEMP_ZSHRC'
p10k configure
"

# Verificar si se generó la configuración
if [[ -f "$TEMP_DIR/.p10k.zsh" ]]; then
    echo "✅ Configuración generada exitosamente"
    
    # Copiar la configuración a nuestro archivo personalizado
    cp "$TEMP_DIR/.p10k.zsh" "$P10K_CUSTOM_CONFIG"
    
    echo "📋 Configuración personalizada guardada en: $P10K_CUSTOM_CONFIG"
    echo ""
    echo "🔄 Para aplicar los cambios:"
    echo "   Ejecuta: exec zsh"
    echo ""
    echo "✨ ¡Configuración completada!"
    echo ""
    echo "💡 Tip: Puedes editar tu configuración con: p10kedit"
else
    echo "❌ No se pudo generar la configuración"
    echo "💡 Puedes editar manualmente: $P10K_CUSTOM_CONFIG"
fi

# Limpiar
rm -rf "$TEMP_DIR" 