# Configuración adicional de Zsh
# Este archivo contiene las configuraciones personalizadas para zsh

# =============================================================================
# CONFIGURACIÓN DE HISTORIAL
# =============================================================================
setopt HIST_IGNORE_DUPS       # No guardar comandos duplicados consecutivos
setopt HIST_IGNORE_ALL_DUPS   # No guardar comandos duplicados en el historial
setopt HIST_IGNORE_SPACE      # No guardar comandos que empiecen con espacio
setopt HIST_SAVE_NO_DUPS      # No guardar duplicados al escribir el historial
setopt SHARE_HISTORY          # Compartir historial entre sesiones

# =============================================================================
# CONFIGURACIÓN DE NAVEGACIÓN
# =============================================================================
setopt AUTO_CD                # Cambiar a directorio sin usar 'cd'
setopt CORRECT                # Corregir comandos
setopt CORRECT_ALL           # Corregir argumentos

# =============================================================================
# CONFIGURACIÓN DE COMPLETADO
# =============================================================================
setopt COMPLETE_IN_WORD      # Completar desde cualquier parte de la palabra
setopt ALWAYS_TO_END         # Mover cursor al final después de completar

# =============================================================================
# FUNCIONES ÚTILES
# =============================================================================

# Función para extraer archivos de cualquier formato
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Función para crear directorio y navegar a él
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# =============================================================================
# CONFIGURACIÓN DE NODE/NVM
# =============================================================================
# Cargar nvm si está instalado
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# =============================================================================
# CONFIGURACIONES ADICIONALES
# =============================================================================
# Habilitar colores en ls
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Configuración para bat (si está instalado)
export BAT_THEME="TwoDark" 