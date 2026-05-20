{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/nvidia.nix
    ./modules/audio.nix
    ./modules/gaming.nix
    # ./modules/llama-cpp.nix
    ./modules/virtualization.nix
  ];

  networking = {
    hostName = "cheesemate";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    envfs.enable = true;
    openssh.enable = true;
  };

  users.users.cheese = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    networkmanagerapplet
    # cudaPackages.cudatoolkit
    mpv
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ 
      libGL 
      stdenv.cc.cc.lib
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXtst
      xorg.libXi
      xorg.libXrandr
      xorg.libXcursor
      xorg.libXinerama
      xorg.libxcb
      xorg.libXfixes
      fontconfig
      freetype
      zlib
    ];
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      auto-optimise-store = true;
      keep-outputs         = true;
      keep-derivations     = true;

      http-connections = 1;
      stalled-download-timeout = 300;
      connect-timeout = 30;
      download-attempts         = 3;
      log-lines                 = 50;
    };

    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 14d";
    };
  };

  system.stateVersion = "25.11";
}
