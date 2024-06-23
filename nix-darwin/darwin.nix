{ lib, pkgs, ... }:
{
  # define the software you want specific to darwin
  environment.systemPackages = with pkgs; [
    iterm2 # terminal emulator
    pkg-config
    # davinic-resolve # video editing (only avaliable in x86_64-linux)
  ];

  programs.zsh.enable = true;
  programs.tmux.iTerm2 = true;

  nix.settings.experimental-features = lib.mkForce [
    "nix-command"
    "flakes"
  ];

  homebrew = {
    enable = true;
    caskArgs = {
      appdir = "~/Applications";
      require_sha = true;
    };
    casks = [
      # gui applications
      "rectangle" # window management
      "cryptomator" # client side cloud storage encryption
      "google-drive" # chosen cloud storage
      "microsoft-office" # TODO: remove after finished uni
      "visual-studio-code" # we only want this for debugging c/c++
    ];
    brews = [
      # commandline tools
    ];
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
        expose-animation-duration = 1.0e-2;
      };

      finder = {
        _FXShowPosixPathInTitle = true; # show full path in the title
        AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # no file extension change warnings
        QuitMenuItem = true; # allows quiting finder
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      # disable natural scroll direction
      NSGlobalDomain."com.apple.swipescrolldirection" = false;

      loginwindow.GuestEnabled = false;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      userKeyMapping = [
        {
          # This overrides the fn key with left-ctrl
          HIDKeyboardModifierMappingSrc = 1095216660483;
          HIDKeyboardModifierMappingDst = 30064771296;
        }
      ];
    };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
