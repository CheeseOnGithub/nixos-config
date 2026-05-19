{
  description = "python";

  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            python3
            python3Packages.pip
            uv
          ];

          shellHook = ''
            if [ ! -d .venv ]; then
              uv venv .venv
            fi
            source .venv/bin/activate
          '';
        };
      });
}
