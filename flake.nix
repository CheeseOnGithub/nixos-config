{
  description = "cheesemate system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    custom-packages.url = "github:Rishabh5321/custom-packages-flake";
  };

  outputs =
    inputs @ {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      spicetify-nix,
      custom-packages,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      extraArgs = {
        inherit pkgs-unstable spicetify-nix custom-packages;
      };
    in
    {
      nixosConfigurations.cheesemate = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = extraArgs;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          spicetify-nix.nixosModules.spicetify

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = extraArgs;
              users.cheese = import ./home;
            };
          }
        ];
      };

      templates = {
        cpp-gl = {
          path = ./templates/cpp-gl;
          description = "C++ OpenGL dev shell";
        };

        cpp = {
          path = ./templates/cpp;
          description = "C++ CMake/Ninja dev shell";
        };

        python = {
          path = ./templates/python;
          description = "Python uv dev shell";
        };

        re = {
          path = ./templates/re;
          description = "Reverse engineering dev shell";
        };

        cpp-win = {
          path = ./templates/cpp-win;
          description = "C++ Windows clang-cl/xwin cross-compile shell";
        };

        go-win = {
          path = ./templates/go-win;
          description = "Go Windows cross-compile shell";
        };

        rust-win = {
          path = ./templates/rust-win;
          description = "Rust Windows MSVC/xwin cross-compile shell";
        };
      };
    };
}
