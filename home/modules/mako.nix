{ ... }:

{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      width = 330;
      height = 80;
      margin = "10,10,0,0";
      padding = "10";
      border-size = 2;
      border-radius = 8;

      icons = true;
      max-icon-size = 32;
      layer = "overlay";

      default-timeout = 4000;

      background-color = "#303446";
      text-color = "#c6d0f5";
      border-color = "#8caaee";
      progress-color = "over #414559";

      font = "JetBrainsMono Nerd Font Mono 10";

      format = "<b>%s</b>\\n%b";
    };
  };
}
