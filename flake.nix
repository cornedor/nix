{
  description = "Corné's darwin system";

  nixConfig ={
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    stablepkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    yolopkgs.url = "github:nixos/nixpkgs/master";

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other sources
    # comma.url = "github:nix-community/comma";
    # comma.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    rooter.url = "github:run-as-root/rooter";
    rooter.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    darwin,
    nixpkgs,
    stablepkgs,
    home-manager,
    nix-vscode-extensions,
    # comma,
    rooter,
    ...
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs.lib) attrValues optionalAttrs singleton;

    # Configuration for `nixpkgs`
    nixpkgsConfig = {
      config = {allowUnfree = true;};
      overlays =
        attrValues self.overlays
        ++ [
          nix-vscode-extensions.overlays.default
          # comma.overlays.default
        ]
        ++ singleton (
          # Sub in x86 version of packages that don't build on Apple Silicon yet
          final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            inherit (final.pkgs-x86);
            # Add packages here that are not available in the aarch64 repo, e.g.
            # clang;
          })
        )
        ++ singleton (
          final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            inherit (final.overlayStable);
            # Add packages here that should be installed from stable
            # vscode-with-extensions;
          })
        );
    };
  in {
    # My `nix-darwin` configs

    darwinConfigurations = {
      corne = let system = "aarch64-darwin"; in darwinSystem {
        system = system;
        specialArgs = {
          inherit inputs;
        };
        modules =
          attrValues self.darwinModules
          ++ [
            # Main `nix-darwin` config
            ./machines/macbook/configuration.nix
            # `home-manager` module
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              # `home-manager` config
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.corne = import ./users/corne.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                # nixvim = nixvim;
                yolopkgs = inputs.yolopkgs.legacyPackages.${system};
              };
            }
          ];
      };
    };

    nixosConfigurations = {
      nini = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          # nixvim = nixvim;
          inherit inputs;
        };
        modules = [
          ./machines/nini/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              # nixvim = nixvim;
              yolopkgs = inputs.yolopkgs.legacyPackages.${system};
            };
            home-manager.users.corne = import ./users/corne.nix;
            home-manager.users.janike = import ./users/janike.nix;
          }
        ];
      };
    };

    # Overlays

    overlays = {
      # Overlay useful on Macs with Apple Silicon
      apple-silicon = final: prev:
        optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          overlayStable = import inputs.stablepkgs {
            system = "aarch64-darwin";
            inherit (nixpkgsConfig) config;
          };
          # Add access to x86 packages system is running Apple Silicon
          pkgs-x86 = import inputs.nixpkgs {
            system = "x86_64-darwin";
            inherit (nixpkgsConfig) config;
          };
        };
    };

    # My `nix-darwin` modules that are pending upstream, or patched versions waiting on upstream
    # fixes.
    darwinModules = {};
  };
}
