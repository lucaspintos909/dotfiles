{ config, pkgs, ... }:

{

  imports = [
    ./modules/bash.nix
    ./modules/neovim.nix
    ./modules/ssh.nix
    ./modules/gnome.nix
    ./modules/keyboard-fix.nix
    ./modules/kitty.nix
    ./modules/zsh.nix
  ];

  home = {
    username = "lpintos";
    homeDirectory = "/home/lpintos";
    stateVersion = "25.05";
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
      kitty
      bat
      zip
      unzip
      curl
      zsh
      zsh-powerlevel10k
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.hack
    ];
  };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  programs.home-manager.enable = true;

  # Configuración de fuentes
  fonts.fontconfig.enable = true;
  
}
