{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-tools
    nixd
    nixfmt-rfc-style
    rust-analyzer
    gopls
    gofumpt
    lua-language-server
    stylua
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.file.".gdbinit".text = ''
    source ${pkgs.gef}/share/gef/gef.py

    gef config context.clear_screen   true
    gef config context.show_stack     true
    gef config context.show_registers true
    gef config context.show_memory    true
  '';
}
