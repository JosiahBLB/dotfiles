{ pkgs, lib, ... }:
{
  home.username = "josiah";
  home.homeDirectory = lib.mkForce "/home/josiah";
  home.stateVersion = "24.05"; # keep on latest stable version

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
      "1password-cli"
      "1password"
    ];
  home.packages = with pkgs; [
    zsh
    vscode
    ripgrep
    cmake
    lazygit

    _1password
    _1password-gui
    # TODO: Figure out how to set this font in iterm2
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # load program specific configurations
  imports = [
    ../nix-home-manager/tmux/tmux.nix
    ../nix-home-manager/zsh/zsh.nix
    ../nix-home-manager/git.nix
    ../nix-home-manager/nvim/nvim.nix
  ];

  home.sessionPath = [
    "/bin"
    "/usr/bin"
  ];

  # programs.tealdeer = {
  #   enable = true;
  #   settings.updates.auto_update = true;
  # };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
}

# Where to store HM
# NobbZ:
# HMs blessed default would be $XDG_CONFIG_HOME/home-manager IIRC.
# Personally I have a copy under my generic "Projects" folder, as I treat my system and home config a software project.
# Though I rarely to never run a switch from the local clone, thats purely for dev and testing. 
# To actually switch I only use the GH remote
