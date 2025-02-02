{ pkgs, lib, ... }:
{
  home.username = "josiah";
  home.homeDirectory = lib.mkForce "/Users/josiah";
  home.stateVersion = "24.05"; # keep on latest stable version

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    cmake
    bear
  ];

  # load program specific configurations
  imports = [
    ../nix-home-manager/tmux/tmux.nix
    ../nix-home-manager/zsh/zsh.nix
    ../nix-home-manager/git.nix
    ../nix-home-manager/nvim/nvim.nix
  ];

  # programs.tealdeer = {
  #   enable = true;
  #   settings.updates.auto_update = true;
  # };

  # use home-manager to manage dotfiles
  home.file = {

    # symlink to the nix store copy:
    # "desired/symlink/location".source = relative/path/to/file/in/nix/flake;
    ".config/ghostty/config".source = ghostty/config;

    # # set the file content:
    # "desired/symlink/location".text = builtins.readFile ./relative/path/to/file/in/nix/flake;
    # or
    # "desired/symlink/location".text = ''hello world!'';
    ".config/ghostty/config".text = builtins.readFile ./ghostty/config;
  };
}
