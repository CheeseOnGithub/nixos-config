{
  description = "cheesemate system";

  inputs = {
    nixpkgs.url         = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    custom-packages.url = "github:Rishabh5321/custom-packages-flake";

    # llama-cpp = { 
    #   url = "github:ggml-org/llama.cpp";
    #   flake = false;
    # };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, spicetify-nix, custom-packages, plasma-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      extraArgs = {
        inherit pkgs-unstable spicetify-nix custom-packages plasma-manager;
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
              sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
              users.cheese = import ./home.nix;
            };
          }
        ];
      };

      templates = {
        cpp-gl = {
          path        = ./templates/cpp-gl;
          description = "cpp opengl";
        };
        cpp = {
          path        = ./templates/cpp;
          description = "cpp cmake ninja";
        };
        python = {
          path        = ./templates/python;
          description = "pytohn uv";
        };
        re = {
          path        = ./templates/re;
          description = "re";
        };
        cpp-win = {
          path = "./templates/win";
          description = "cpp compile for windows";
        };
      };

    };
}
