{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];
  # define the software you want for all installations
  environment.systemPackages = with pkgs; [
    # editors
    vim
    neovim
    vscode

    # dev
    ninja
    nodejs_20

    # cli tools
    unzip
    glances
    lazygit # git gui
    lsd # ls and tree replacement
    ripgrep # grep replacement
    fzf # fuzzy finder
    fd # find replacement
    tealdeer # man replacement
    sioyek # pdf reader
    tmux # terminal multiplexer (an alternative is zellij)

    # networking
    stevenblack-blocklist
  ];

  fonts.packages = with pkgs; [ jetbrains-mono ];

  environment.variables.EDITOR = "nvim";

  # Auto garbage collect
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # TODO: Figure out why these aren't added to our host list
  # block ads and explict content 
  lib.networking.hostFiles = [ "${pkgs.stevenblack-blocklist}/hosts" ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility
  system.stateVersion = 4;
}
