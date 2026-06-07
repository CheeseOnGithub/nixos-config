{ ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };

    style = ''
      window {
        background-color: #303446;
        border-radius: 12px;
        border: 2px solid #8caaee;
      }
      #input {
        background-color: #414559;
        color: #c6d0f5;
        border-radius: 8px;
        border: none;
        padding: 8px 12px;
        margin: 8px;
        font-family: "JetBrains Mono";
        font-size: 14px;
      }
      #entry {
        border-radius: 8px;
        padding: 4px 8px;
      }
      #entry:selected {
        background-color: #414559;
      }
      #text {
        color: #c6d0f5;
        font-family: "JetBrains Mono";
      }
      #text:selected { color: #8caaee; }
      #img { margin-right: 8px; }
    '';
  };
}
