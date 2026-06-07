{ pkgs, lib, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    videoDrivers = [ "nvidia" ];
  };

  services.desktopManager.plasma6.enable = lib.mkForce false;
  services.displayManager.sddm.enable = lib.mkForce false;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      user = "greeter";
    };
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
  };

  programs = {
    firefox.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    dconf.enable = true;
    thunar.enable = true;

    spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    waybar
    wofi
    mako
    wl-clipboard
    grim
    slurp
    hyprshot
    pavucontrol
    networkmanagerapplet

    xfce.thunar
    xfce.thunar-volman
    xfce.tumbler
    gvfs
    papirus-icon-theme
    adwaita-icon-theme
  ];

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      font-awesome
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
}
