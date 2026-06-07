{ pkgs, ... }:

{
  programs.steam.enable = true;

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    lutris
    vinegar
    prismlauncher
    bluez
  ];
}
