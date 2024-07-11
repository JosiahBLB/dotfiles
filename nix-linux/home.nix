{ pkgs, lib, ... }:
{
  home.username = "josiah";
  home.homeDirectory = lib.mkForce "/home/josiah";
  home.stateVersion = "24.05"; # keep on latest stable version

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    cmake
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

  home.activation.chsh = "-s ${pkgs.zsh}/bin/zsh";

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
