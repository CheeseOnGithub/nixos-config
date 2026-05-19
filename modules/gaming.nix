{ pkgs, lib, pkgs-unstable, ... }:

let
  gstPlugins = with pkgs.gst_all_1; [
    gstreamer
    gst-plugins-base
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
  ];
in
{
  programs.steam.enable = true;

  hardware = {
    graphics.enable32Bit = true;
    bluetooth.enable     = true;
  };

  services.flatpak.enable = true;

  environment = {
    systemPackages = with pkgs; [
      wineWowPackages.stable
      winetricks
      lutris
      vinegar
    ] ++ gstPlugins;

    sessionVariables.GST_PLUGIN_PATH_1_0 =
      lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" gstPlugins;
  };
}
