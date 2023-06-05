{
  description = "Node 18 development environment";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs"
  };

  # Flake outputs
  outputs = {
    self,
    nixpkgs,
    flake-utils
  }:
    flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nodejs-18_x
          pkgs.nodePackages.yarn
          pkgs.nodePackages.typescript
          pkgs.nodePackages.typescript-language-server
        ];
      };
    });
}
