{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Configuración de oh-my-zsh  
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # Tema por defecto, fácil de cambiar
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
    };
    
    # Variables de entorno
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "brave";
      TERMINAL = "kitty";
    };
    
    # Cargar configuración adicional desde archivo externo
    initExtra = builtins.readFile ../scripts/zsh-config.sh;
    
    # Configuración del historial
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
  };
} 