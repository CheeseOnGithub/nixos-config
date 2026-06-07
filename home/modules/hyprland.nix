{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$menu" = "wofi --show drun";

      monitor = [
        "HDMI-A-1,1920x1080@143.98,0x0,1"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        accel_profile = "flat";
        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = "rgba(89b4faff)";
        "col.inactive_border" = "rgba(313244ff)";
      };

      decoration = {
        rounding = 8;

        blur = {
          enabled = true;
          size = 4;
          passes = 2;
          new_optimizations = true;
        };

        shadow = {
          enabled = true;
          range = 12;
          render_power = 3;
          color = "rgba(00000066)";
        };
      };

      animations = {
        enabled = true;
        bezier = [ "easeOutQuint,0.23,1,0.32,1" ];
        animation = [
          "windows,1,4,easeOutQuint"
          "windowsOut,1,3,easeOutQuint"
          "border,1,6,default"
          "fade,1,4,default"
          "workspaces,1,3,easeOutQuint"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };

      env = [
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Bibata-Modern-Ice"
        "HYPRCURSOR_SIZE,24"
      ];

      bind = [
        "$mod, Return, exec, alacritty"
        "$mod, Space, exec, wofi --show drun"
        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod SHIFT, F, togglefloating"
        "$mod SHIFT, E, exit"
        "$mod SHIFT, S, exec, hyprshot -m region --clipboard-only"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        "$mod CTRL, left, resizeactive, -40 0"
        "$mod CTRL, right, resizeactive, 40 0"
        "$mod CTRL, up, resizeactive, 0 -40"
        "$mod CTRL, down, resizeactive, 0 40"
        "$mod CTRL SHIFT, left, resizeactive, -100 0"
        "$mod CTRL SHIFT, right, resizeactive, 100 0"
        "$mod CTRL SHIFT, up, resizeactive, 0 -100"
        "$mod CTRL SHIFT, down, resizeactive, 0 100"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "fullscreen, class:^(steam_app_.*)$"
        "immediate, class:^(steam_app_.*)$"
        "float, title:^(Picture-in-Picture)$"
        "float, class:^(pavucontrol)$"
        "float, class:^(nm-connection-editor)$"
      ];

      exec-once = [
        "waybar"
        "nm-applet --indicator"
      ];
    };
  };
}
