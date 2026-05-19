{ pkgs, pkgs-unstable, custom-packages, ... }:

{
  home = {
    username      = "cheese";
    homeDirectory = "/home/cheese";
    stateVersion  = "25.11";

    packages = with pkgs; [
      (symlinkJoin {
        name        = "ghidra";
        paths       = [ ghidra ];
        buildInputs = [ makeWrapper ];
        postBuild   = ''
          wrapProgram $out/bin/ghidra --set MAXMEM 12G
        '';
      })
      gdb
      lldb
      gef
      radare2
      binutils

      clang-tools
      devenv
      nixd
      nixfmt-rfc-style
      python3
      jetbrains-toolbox
      (pkgs.writeShellScriptBin "clion" ''
        exec /home/cheese/.local/share/JetBrains/Toolbox/apps/clion/bin/clion "$@"
      '')

      fastfetch
      file
      p7zip

      telegram-desktop
      obsidian
      qbittorrent
      custom-packages.packages.${pkgs.system}.seanime

      papirus-icon-theme
    ];

    file.".gdbinit".text = ''
      source ${pkgs.gef}/share/gef/gef.py

      gef config context.clear_screen   true
      gef config context.show_stack     true
      gef config context.show_registers true
      gef config context.show_memory    true
    '';
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable       = true;
      settings.user = {
        name  = "CheeseOnGithub";
        email = "92813629+CheeseOnGithub@users.noreply.github.com";
      };
    };

    direnv = {
      enable            = true;
      nix-direnv.enable = true;
    };

    obs-studio = {
      enable  = true;
      package = pkgs.obs-studio;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-gstreamer
        obs-vkcapture
      ];
    };

    vscode = {
      enable               = true;
      package              = pkgs.vscodium;
      mutableExtensionsDir = false;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          llvm-vs-code-extensions.vscode-clangd
          ms-python.python
          jnoortheen.nix-ide
          mkhl.direnv
          twxs.cmake
          vadimcn.vscode-lldb
          continue.continue
        ];

        userSettings = {
          "clangd.path"      = "${pkgs.clang-tools}/bin/clangd";
          "clangd.arguments" = [ "--background-index" ];

          "nix.enableLanguageServer"   = true;
          "nix.serverPath"             = "nixd";
          "nix.serverSettings".nixd = {
            formatting.command = [ "nixfmt" ];
            options = {
              nixos.expr        = "(builtins.getFlake \"/home/cheese/nixos-config\").nixosConfigurations.cheesemate.options";
              home-manager.expr = "(builtins.getFlake \"/home/cheese/nixos-config\").homeConfigurations.cheese.options";
            };
          };
        };
      };
    };

    plasma = {
      enable = true;

      workspace = {
        colorScheme = "Catppuccin-Frappe-Blue";
        theme       = "breeze-dark";
        iconTheme   = "Papirus-Dark";
        cursor = {
          theme = "breeze_cursors";
          size  = 24;
        };
      };

      fonts = {
        general     = { family = "Noto Sans";       pointSize = 10; };
        fixedWidth  = { family = "Source Code Pro"; pointSize = 10; };
        small       = { family = "Noto Sans";       pointSize = 8;  };
        toolbar     = { family = "Noto Sans";       pointSize = 10; };
        menu        = { family = "Noto Sans";       pointSize = 10; };
        windowTitle = { family = "Noto Sans";       pointSize = 10; };
      };

      panels = [
        {
          location   = "bottom";
          height     = 56;
          floating   = true;
          alignment  = "center";
          lengthMode = "fit";
          hiding     = "dodgewindows";
          widgets = [
            { iconTasks = {
                launchers = [
                  "applications:kitty.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:firefox.desktop"
                  "applications:vscodium.desktop"
                ];
                appearance.showTooltips = false;
              };
            }
          ];
        }
        {
          location = "top";
          height   = 32;
          floating = false;
          widgets = [
            "org.kde.plasma.pager"
            "org.kde.plasma.marginsseparator"
            {
              digitalClock = {
                date.format = "shortDate";
                time.format = "24h";
              };
            }
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.systemtray"
            "org.kde.plasma.lock_logout"
          ];
        }
      ];

      kwin = {
        effects = {
          wobblyWindows.enable = false;
          blur.enable          = true;
        };
      };

      shortcuts = {
        "services/wofi.desktop"."_launch" = "Meta+Space";
        "services/kitty.desktop"."_launch" = "Meta+Return";
        "kwin"."Window Close"             = "Meta+Q";

        "kwin"."Window Maximize"          = "Meta+Up";
        "kwin"."Switch to Desktop 1"      = "Meta+1";
        "kwin"."Switch to Desktop 2"      = "Meta+2";
        "kwin"."Switch to Desktop 3"      = "Meta+3";
        "kwin"."Switch to Desktop 4"      = "Meta+4";
      };

      configFile = {
        "dolphinrc"."General"."BrowseThroughArchives" = false;
        "dolphinrc"."General"."OpenArchivesAsFolder"  = false;
        "plasmarc"."PlasmaToolTips"."Delay"           = -1;
        "kdeglobals"."KDE"."widgetStyle"              = "kvantum";
        "kdeglobals"."General"."ColorScheme"          = "Catppuccin-Frappe-Blue";
      };
    };

    kitty = {
      enable = true;
      font = {
        name = "Source Code Pro";
        size = 12;
      };
      settings = {
        background_opacity   = "0.85";
        confirm_os_window_close = 0;
        cursor_shape         = "beam";

        # catppuccin frappe
        foreground           = "#c6d0f5";
        background           = "#303446";
        selection_background = "#414559";
        cursor               = "#f2d5cf";
        color0  = "#51576d"; color8  = "#626880";
        color1  = "#e78284"; color9  = "#e78284";
        color2  = "#a6d189"; color10 = "#a6d189";
        color3  = "#e5c890"; color11 = "#e5c890";
        color4  = "#8caaee"; color12 = "#8caaee";
        color5  = "#f4b8e4"; color13 = "#f4b8e4";
        color6  = "#81c8be"; color14 = "#81c8be";
        color7  = "#b5bfe2"; color15 = "#a5adce";
      };
    };

    wofi = {
      enable = true;
      settings = {
        width           = 600;
        height          = 400;
        location        = "center";
        show            = "drun";
        prompt          = "Search...";
        filter_rate     = 100;
        allow_markup    = true;
        no_actions      = true;
        halign          = "fill";
        orientation     = "vertical";
        content_halign  = "fill";
        insensitive     = true;
        allow_images    = true;
        image_size      = 40;
        gtk_dark        = true;
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
          font-family: "Source Code Pro";
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
          font-family: "Source Code Pro";
        }
        #text:selected { color: #8caaee; }
        #img { margin-right: 8px; }
      '';
    };
  };
}
