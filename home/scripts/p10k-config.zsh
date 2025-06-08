# Configuración de Powerlevel10k
# Para regenerar esta configuración, ejecuta: p10k configure

# Configuración básica de Powerlevel10k
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# =============================================================================
# ELEMENTOS DEL PROMPT
# =============================================================================

# Elementos del prompt izquierdo
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir                     # Directorio actual
  vcs                     # Control de versiones (git)
  newline                 # Nueva línea
  prompt_char            # Carácter del prompt
)

# Elementos del prompt derecho
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status                  # Estado del último comando
  command_execution_time  # Tiempo de ejecución
  background_jobs        # Jobs en background
  virtualenv             # Entorno virtual Python
  node_version           # Versión de Node.js
  context                # Usuario@host
  time                   # Hora
)

# =============================================================================
# CONFIGURACIÓN DE ELEMENTOS ESPECÍFICOS
# =============================================================================

# Directorio
typeset -g POWERLEVEL9K_DIR_FOREGROUND=31
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=

# Git/VCS
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=76
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=178
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=76

# Prompt character
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196

# Tiempo de ejecución
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=101

# Context (user@host)
typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=180
typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

# Node.js
typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=70

# Virtualenv
typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=37

# Tiempo
typeset -g POWERLEVEL9K_TIME_FOREGROUND=66
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'

# =============================================================================
# CONFIGURACIONES GENERALES
# =============================================================================

# Separadores
typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%246F\uE0C1'
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%246F\uE0C3'

# Iconos
typeset -g POWERLEVEL9K_MODE='nerdfont-complete'

# Colores
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=''
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=''

# Instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi 