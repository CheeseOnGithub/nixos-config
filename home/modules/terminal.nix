{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.85;
      };

      font = {
        size = 12;

        normal = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Regular";
        };

        bold = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Bold";
        };

        italic = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Italic";
        };
      };
      
      cursor = {
        style = "Beam";
      };

      # Catppuccin Frappe
      colors = {
        primary = {
          background = "#303446";
          foreground = "#c6d0f5";
        };

        cursor = {
          text = "#303446";
          cursor = "#f2d5cf";
        };

        normal = {
          black = "#51576d";
          red = "#e78284";
          green = "#a6d189";
          yellow = "#e5c890";
          blue = "#8caaee";
          magenta = "#f4b8e4";
          cyan = "#81c8be";
          white = "#b5bfe2";
        };

        bright = {
          black = "#626880";
          red = "#e78284";
          green = "#a6d189";
          yellow = "#e5c890";
          blue = "#8caaee";
          magenta = "#f4b8e4";
          cyan = "#81c8be";
          white = "#a5adce";
        };
      };
    };
  };
}
