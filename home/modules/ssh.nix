{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    # Opcional: configuración por host
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/ceibal";
      };

      "bitbucket.org" = {
        user = "git";
        hostname = "bitbucket.org";
        identityFile = "~/.ssh/ceibal";
        identitiesOnly = true;
      };

    };
  };
}

