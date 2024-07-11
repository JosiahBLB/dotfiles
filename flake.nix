{
  description = "Josiah's Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      homebrew-bundle,
    }:
    let
      inherit (self) outputs;
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#genericDarwin
      darwinConfigurations = {
        genericDarwin = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./common.nix
            ./nix-darwin/default.nix

            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = "josiah";

                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
              };
            }

            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.josiah = import ./nix-darwin/home.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };

      homeConfigurations = {
        linuxHome = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [ ./nix-linux/home.nix ];
        };
      };

      # For easy access to home-manager configurations i.e:
      #   home-manager switch --flake .#linuxHome
      packages.x86_64-linux = {
        linuxHome = self.homeConfigurations.linuxHome.activationPackage;
      };
    };
}
