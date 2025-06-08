{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Configuración de oh-my-zsh sin powerlevel10k
    oh-my-zsh = {
      enable = true;
      # Usaremos un tema básico por ahora
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo" 
        "docker"
        "kubectl"
        "npm"
        "node"
        "nvm"
        "history"
        "common-aliases"
        "colored-man-pages"
        "command-not-found"
        "extract"
        "z"
      ];
    };
    
    # Aliases compartidos con bash para consistencia
    shellAliases = 
    let 
        flakePath = "~/nix";
    in {
      # Aliases de sistema
      rebuild = "sudo nixos-rebuild switch --flake ${flakePath}";
      hms = "home-manager switch --flake ${flakePath}";
      
      # Aliases de herramientas
      vim = "nvim";
      vi = "nvim";
      ls = "ls -lah";
      l = "ls";
      sl = "ls";
      la = "ls";  
      ll = "ls";
      cat = "bat";
      mkdir = "mkdir -p";
      rmdir = "rmdir -p";
      ".." = "cd ..";
      
      # Aliases específicos de zsh
      reload = "source ~/.zshrc";
      zshconfig = "nvim ~/.zshrc";
      ohmyzsh = "nvim ~/.oh-my-zsh";
      
      # Aliases específicos de Powerlevel10k
      p10kconfig = "~/.local/bin/p10k-setup";
      p10kreload = "source ~/.config/zsh/p10k-custom.zsh 2>/dev/null || source ~/.config/zsh/p10k-config.zsh";
      p10kedit = "nvim ~/.config/zsh/p10k-custom.zsh";
      p10kreset = "rm -f ~/.config/zsh/p10k-custom.zsh && exec zsh";
    };
    
    # Variables de entorno
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "brave";
      TERMINAL = "kitty";
    };
    
    # Cargar Powerlevel10k y configuración adicional
    initExtra = ''
      # Cargar Powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      
      # Cargar configuración personalizada
      ${builtins.readFile ../scripts/zsh-config.sh}
    '';
    
    # Configuración del historial
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
  };

  # Instalar archivo de configuración de Powerlevel10k
  home.file.".config/zsh/p10k-config.zsh".source = ../scripts/p10k-config.zsh;
  
  # Instalar script de configuración
  home.file.".local/bin/p10k-setup" = {
    source = ../scripts/p10k-setup.sh;
    executable = true;
  };
} 