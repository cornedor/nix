{
  description = "Node 14 development environment";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs"
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
            nodejs = super.nodejs-14_x;
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
