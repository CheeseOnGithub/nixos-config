{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/core.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/nvidia.nix
    ./modules/audio.nix
    ./modules/gaming.nix
    ./modules/virtualization.nix
  ];

  system.stateVersion = "25.11";
}
