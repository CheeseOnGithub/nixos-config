{ ... }:

{
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      spacing = 4;

      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];

      modules-center = [ ];

      modules-right = [
        "cpu"
        "memory"
        "pulseaudio"
        "network"
        "bluetooth"
        "clock"
        "tray"
      ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{icon}";

        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "󰊴";
          "7" = "󰎄";
          "8" = "󰙯";
          "9" = "󰕧";
          urgent = "";
          focused = "";
          default = "";
        };

        persistent-workspaces."*" = 5;
      };

      "hyprland/window" = {
        format = "{}";
        max-length = 70;
        separate-outputs = true;
      };

      cpu = {
        format = "CPU {usage}%";
        interval = 2;
      };

      memory = {
        format = "RAM {}%";
        interval = 2;
      };

      pulseaudio = {
        format = "VOL {volume}%";
        format-muted = "MUTED";
        scroll-step = 5;
      };

      network = {
        format-wifi = " {essid}";
        format-ethernet = "󰈀 wired";
        format-disconnected = "OFFLINE";
        tooltip-format = "{ifname}: {ipaddr}";
      };

      bluetooth = {
        format = "󰂯";
        format-disabled = "󰂲";
        format-off = "󰂲";
        format-connected = "󰂱 {num_connections}";
        format-connected-battery = "󰂱 {num_connections} {device_battery_percentage}%";
        tooltip-format = "{controller_alias}\t{controller_address}";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
      };

      clock = {
        format = "{:%H:%M}";
        tooltip-format = "{:%A, %d %B %Y}";
      };

      tray.spacing = 10;
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font Mono", "Noto Sans";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: #1e1e2e;
        color: #cdd6f4;
      }

      #workspaces {
        margin-left: 8px;
        padding: 0;
      }

      #workspaces button {
        padding: 0 12px;
        margin: 3px 2px;
        min-width: 24px;
        min-height: 24px;
        color: #a6adc8;
        background: transparent;
        border-radius: 6px;
      }

      #workspaces button label {
        font-family: "JetBrainsMono Nerd Font Mono";
        font-size: 20px;
      }

      #workspaces button.active {
        color: #89b4fa;
        background: #313244;
      }

      #workspaces button:hover {
        color: #cdd6f4;
        background: #45475a;
      }

      #window {
        padding: 0 12px;
        color: #cdd6f4;
      }

      #cpu,
      #memory,
      #pulseaudio,
      #network,
      #bluetooth,
      #clock,
      #tray {
        padding: 0 10px;
        margin: 4px 2px;
        background: #313244;
        color: #cdd6f4;
        border-radius: 6px;
      }

      #cpu { color: #a6e3a1; }
      #memory { color: #cba6f7; }
      #pulseaudio { color: #89b4fa; }
      #network { color: #94e2d5; }
      #bluetooth { color: #89b4fa; }
      #clock {
        color: #fab387;
        margin-right: 8px;
      }
      #tray { padding: 0 8px; }
    '';
  };
}
