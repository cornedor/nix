{
  description = "Node 21 development environment";

  # Flake inputs
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs"
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  # Flake outputs
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (self: super: {
            nodejs = super.nodejs_21;
          })
        ];
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nodejs
          pkgs.nodePackages.yarn
          pkgs.nodePackages.typescript
          pkgs.nodePackages.typescript-language-server
        ];
      };
    });
}
