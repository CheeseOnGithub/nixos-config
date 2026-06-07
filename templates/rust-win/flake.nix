{
  description = "rust win cross compile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };

      rustToolchain = pkgs.rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rustfmt"
          "clippy"
          "rust-analyzer"
        ];
        targets = [ "x86_64-pc-windows-msvc" ];
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          rustToolchain
          clang
          lld
          llvmPackages.llvm
          file
        ];

        shellHook = ''
          export XWIN_ROOT="''${XWIN_ROOT:-$HOME/.xwin}"
          echo "Rust Windows MSVC shell"
          echo "Expected xwin path: $XWIN_ROOT"
          echo "Build: ./build.sh"
        '';
      };
    };
}
