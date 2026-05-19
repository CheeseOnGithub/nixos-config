{
  description = "cpp opengl";

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
            cmake
            ninja
            gcc
            pkg-config
            clang-tools
          ];

          buildInputs = with pkgs; [
            glfw
            libGL
            libGLU
            mesa
            glm
            freetype
            xorg.libX11
            xorg.libXrandr
            xorg.libXi
            xorg.libXcursor
            xorg.libXinerama
            wayland
            libxkbcommon
          ];

          shellHook = ''
            export LD_LIBRARY_PATH="${pkgs.libGL}/lib:${pkgs.mesa}/lib:$LD_LIBRARY_PATH"
          '';
        };
      });
}
