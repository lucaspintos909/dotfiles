# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include GNOME module
      #./modules/gnome.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  networking.hostName = "ON1RI4-server"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Montevideo";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_UY.UTF-8";
    LC_IDENTIFICATION = "es_UY.UTF-8";
    LC_MEASUREMENT = "es_UY.UTF-8";
    LC_MONETARY = "es_UY.UTF-8";
    LC_NAME = "es_UY.UTF-8";
    LC_NUMERIC = "es_UY.UTF-8";
    LC_PAPER = "es_UY.UTF-8";
    LC_TELEPHONE = "es_UY.UTF-8";
    LC_TIME = "es_UY.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  services.xserver = {
    enable = true;
    layout = "latam";
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
    desktopManager = {
      gnome = {
        enable = true;
      };
    };
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Docker
  virtualisation.docker= {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = false;
    };
  };
  
  # Define a user account. Don't forget to set a password with 'passwd'.  
  users.users.lpintos = {
    isNormalUser = true;
    description = "Lucas Pintos";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvThDJivh/pDPptZccxjEoTO5/t9vr/um8KBP+S7ly4 lucaspintos909@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINeVXxY9qLZO2kkY0XP3mh3ntT71xgYihwpb0jNVIpwL root@coolify"
    ];
    shell = pkgs.zsh;
  };


  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Enable dconf
  programs.dconf.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    home-manager
    pass-wayland
    xdg-utils
    git
    openfortivpn
    wget
    fastfetch
    neovim
    btop
    tmux
    dconf
    dconf2nix
    openssl
    dig
    kubectl
    zsh
  ];
  
  programs.zsh.enable = true;

  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "latam";
    XKB_DEFAULT_OPTIONS = "terminate:ctrl_alt_bksp";
    # Compatibilidad con aplicaciones GTK/Qt
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
  };
  

  # Enable the Tailscale daemon.
  services.tailscale.enable = true;
  
  # Firewall configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ]; # SSH
    extraCommands = ''
      # Allow traffic from Docker networks to Docker host
      iptables -A INPUT -s 172.18.0.0/16 -d 172.17.0.1 -j ACCEPT
      iptables -A INPUT -s 172.17.0.0/16 -d 172.17.0.1 -j ACCEPT
    '';
  };
  
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      "Port" = 22;
      "PasswordAuthentication" = false;
    };
  };

  # Disable auto-suspend
  services.xserver.displayManager.gdm.autoSuspend = false;

  # Systemd sleep settings
  systemd.sleep = {
    extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';
  };

  system.stateVersion = "25.05";
}
