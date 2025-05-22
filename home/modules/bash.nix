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
      la = "ls -la";
      l = "ls -la";
    };
  };
}
