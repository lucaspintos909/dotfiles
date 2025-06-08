{
  programs.bash = {
    enable = true;
    shellAliases = 
    let 
        flakePath = "~/nix";
    in {
      rebuild = "sudo nixos-rebuild switch --flake ${flakePath}";
      hms = "home-manager switch --flake ${flakePath}";
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
    };
  };
}
