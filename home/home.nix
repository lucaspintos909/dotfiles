{ config, pkgs, ... }:

{

  imports = [
    ./modules/bash.nix
    ./modules/neovim.nix
    ./modules/ssh.nix
  ];

  home = {
    username = "lpintos";
    homeDirectory = "/home/lpintos";
    stateVersion = "24.11";
    packages = with pkgs; [
      nodejs_22
      pnpm
      tree
      slack
      brave
      jetbrains.datagrip
      code-cursor
      termius
      vscode
      prismlauncher
      spotify
      discord
    ];
  };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  programs.home-manager.enable = true;
  
}
