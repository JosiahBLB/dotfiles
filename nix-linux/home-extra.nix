{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];
  home.packages = with pkgs; [
    vscode
    tealdeer
  ];

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };
}

# Where to store HM
# NobbZ:
# HMs blessed default would be $XDG_CONFIG_HOME/home-manager IIRC.
# Personally I have a copy under my generic "Projects" folder, as I treat my system and home config a software project.
# Though I rarely to never run a switch from the local clone, thats purely for dev and testing. 
# To actually switch I only use the GH remote
