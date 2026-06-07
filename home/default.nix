{ ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/git.nix
    ./modules/terminal.nix
    ./modules/dev.nix
    ./modules/neovim.nix
    ./modules/desktop.nix
    ./modules/screen-recorder.nix
    ./modules/zathura.nix
    ./modules/waybar.nix
    ./modules/mako.nix
    ./modules/hyprland.nix
    ./modules/fastfetch.nix
    ./modules/ssh.nix
  ];

  home = {
    username = "cheese";
    homeDirectory = "/home/cheese";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
