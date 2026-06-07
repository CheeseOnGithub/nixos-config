{ pkgs, custom-packages, ... }:

{
  home.packages = with pkgs; [
    fastfetch
    chafa
    file
    p7zip
    btop
    ripgrep
    fd
    fzf
    jq
    unzip

    (symlinkJoin {
      name = "ghidra";
      paths = [ ghidra ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/ghidra --set MAXMEM 12G
      '';
    })
    gdb
    lldb
    gef
    radare2
    binutils

    telegram-desktop
    transmission
    tor-browser
    custom-packages.packages.${pkgs.system}.seanime
    jrnl
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
