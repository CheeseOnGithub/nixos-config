{ pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  services = {
    xserver.enable           = true;
    displayManager.sddm.enable    = true;
    desktopManager.plasma6.enable = true;
  };


  environment.systemPackages = with pkgs; [
    catppuccin-kde
    catppuccin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    gwenview
    okular
    khelpcenter
  ];

  xdg.portal = {
    enable       = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  };

  programs = {
    firefox.enable = true;

    spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle
      ];
      theme       = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
