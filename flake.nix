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
      # $ darwin-rebuild build --flake .#Josiahs-MacBook-Pro
      darwinConfigurations = {
        genericDarwin = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./common.nix
            ./nix-darwin/darwin.nix

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

            # TODO: Split home-manager up for system specific install
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

      nixosConfigurations = {
        genericLinux = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./common.nix ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };

      # Expose the package set, including overlays, for convenience.
    };
}
