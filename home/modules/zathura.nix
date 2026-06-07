{ ... }:

{
  programs.zathura = {
    enable = true;

    extraConfig = ''
      set font "JetBrainsMono Nerd Font Mono 11"
      set default-bg "#303446"
      set default-fg "#c6d0f5"

      set statusbar-bg "#303446"
      set statusbar-fg "#c6d0f5"
      set inputbar-bg "#303446"
      set inputbar-fg "#c6d0f5"
      set notification-bg "#303446"
      set notification-fg "#c6d0f5"

      set notification-error-bg "#e78284"
      set notification-error-fg "#303446"
      set notification-warning-bg "#e5c890"
      set notification-warning-fg "#303446"

      set highlight-color "#e5c890"
      set highlight-active-color "#8caaee"

      set completion-bg "#303446"
      set completion-fg "#c6d0f5"
      set completion-highlight-bg "#414559"
      set completion-highlight-fg "#8caaee"

      set index-bg "#303446"
      set index-fg "#c6d0f5"
      set index-active-bg "#414559"
      set index-active-fg "#8caaee"

      set page-padding 4
      set statusbar-h-padding 8
      set statusbar-v-padding 4
      set adjust-open width
      set window-title-basename true
      set selection-clipboard clipboard

      set recolor true
      set recolor-keephue true
      set recolor-lightcolor "#303446"
      set recolor-darkcolor "#c6d0f5"

      map u scroll half-up
      map d scroll half-down
      map <C-r> recolor
      map i recolor
      map R reload
    '';
  };
}
