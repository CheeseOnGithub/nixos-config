{ ... }:

{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      width = 380;
      height = 90;
      margin = "15,15,0,0";
      padding = "8";
      outer-margin = 3;
      border-size = 2;
      border-radius = 10;

      icons = true;
      max-icon-size = 48;
      layer = "overlay";
      default-timeout = 5000;

      on-button-left = "invoke-default-action";
      on-button-middle = "none";
      on-button-right = "dismiss";

      background-color = "#1e1e2eee";
      text-color = "#cdd6f4";
      border-color = "#89b4fa";
      progress-color = "over #313244";
      font = "JetBrainsMono Nerd Font Mono 11";
      format = "<b>%s</b>\\n%b";
      max-visible = 5;
      sort = "-time";

      "urgency=low" = {
        border-color = "#313244";
        default-timeout = 3000;
      };

      "urgency=normal" = {
        border-color = "#89b4fa";
        default-timeout = 5000;
      };

      "urgency=high" = {
        border-color = "#f38ba8";
        background-color = "#1e1e2eee";
        text-color = "#cdd6f4";
        default-timeout = 8000;
      };
    };
  };
}
