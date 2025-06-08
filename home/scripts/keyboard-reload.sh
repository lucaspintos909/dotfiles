#!/usr/bin/env bash

# Script para recargar el layout de teclado después de home-manager switch
# Autor: Configuración NixOS
# Propósito: Solucionar el problema de pérdida de layout después de hm switch

set -euo pipefail

# Configuración
LAYOUT="latam"
OPTIONS="terminate:ctrl_alt_bksp"

# Rutas de binarios (serán substituidas por Nix)
SETXKBMAP="@setxkbmap@"
DCONF="@dconf@"

log_info() {
    echo "ℹ️  $1"
}

log_success() {
    echo "✅ $1"
}

log_warning() {
    echo "⚠️  $1"
}

log_error() {
    echo "❌ $1"
}

# Función para configurar setxkbmap
configure_setxkbmap() {
    if [[ -x "$SETXKBMAP" ]]; then
        if "$SETXKBMAP" -layout "$LAYOUT" -option "$OPTIONS"; then
            log_success "setxkbmap configurado correctamente"
        else
            log_error "Error configurando setxkbmap"
            return 1
        fi
    else
        log_warning "setxkbmap no está disponible en: $SETXKBMAP"
        return 1
    fi
}

# Función para configurar GNOME
configure_gnome() {
    if [[ -x "$DCONF" ]]; then
        local success=true
        
        if ! "$DCONF" write /org/gnome/desktop/input-sources/sources "[('xkb', '$LAYOUT')]"; then
            log_error "Error escribiendo sources en dconf"
            success=false
        fi
        
        if ! "$DCONF" write /org/gnome/desktop/input-sources/xkb-options "['$OPTIONS']"; then
            log_error "Error escribiendo xkb-options en dconf"
            success=false
        fi
        
        if ! "$DCONF" write /org/gnome/desktop/input-sources/current 'uint32 0'; then
            log_error "Error configurando current en dconf"
            success=false
        fi
        
        if $success; then
            log_success "GNOME configurado correctamente"
        else
            return 1
        fi
    else
        log_warning "dconf no está disponible en: $DCONF"
        return 1
    fi
}

# Función para verificar configuración
verify_configuration() {
    log_info "Verificando configuración..."
    
    if [[ -x "$SETXKBMAP" ]]; then
        echo "📋 Configuración setxkbmap:"
        "$SETXKBMAP" -query 2>/dev/null || log_warning "No se pudo verificar setxkbmap"
    fi
    
    if [[ -x "$DCONF" ]]; then
        echo "📋 Configuración GNOME:"
        echo "  Sources: $("$DCONF" read /org/gnome/desktop/input-sources/sources 2>/dev/null || echo 'N/A')"
        echo "  Options: $("$DCONF" read /org/gnome/desktop/input-sources/xkb-options 2>/dev/null || echo 'N/A')"
    fi
}

# Función principal
main() {
    log_info "Iniciando recarga del layout de teclado..."
    log_info "Usando setxkbmap: $SETXKBMAP"
    log_info "Usando dconf: $DCONF"
    
    # Esperar un momento para que los procesos anteriores terminen
    sleep 1
    
    local x11_success=false
    local gnome_success=false
    
    # Configurar para X11/Xorg
    if [[ -n "${DISPLAY:-}" ]]; then
        log_info "Detectado X11/Xorg (DISPLAY=$DISPLAY)"
        if configure_setxkbmap; then
            x11_success=true
        fi
    fi
    
    # Configurar para Wayland/GNOME
    if [[ "${XDG_SESSION_TYPE:-}" == "wayland" ]] || [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
        log_info "Detectado Wayland/GNOME (XDG_SESSION_TYPE=${XDG_SESSION_TYPE:-}, WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-})"
        if configure_gnome; then
            gnome_success=true
        fi
        
        # También intentar setxkbmap para aplicaciones X11 en Wayland
        configure_setxkbmap || true
    fi
    
    # Si no se detectó el tipo de sesión, intentar configuración genérica
    if [[ "${XDG_SESSION_TYPE:-}" != "wayland" ]] && [[ -z "${WAYLAND_DISPLAY:-}" ]] && [[ -z "${DISPLAY:-}" ]]; then
        log_info "Tipo de sesión no detectado, usando configuración genérica"
        configure_setxkbmap || true
    fi
    
    # Verificar configuración
    verify_configuration
    
    # Resultado final
    if $x11_success || $gnome_success; then
        log_success "Layout de teclado recargado exitosamente"
        exit 0
    else
        log_error "No se pudo recargar el layout de teclado"
        exit 1
    fi
}

# Ejecutar función principal
main "$@" 