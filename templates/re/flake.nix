{
  description = "re";

  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            gdb
            gef
            lldb
            pwndbg
            radare2
            binutils
            file
            hexdump
            python3
            python3Packages.pwntools
            python3Packages.pycryptodome
            netcat-openbsd
            nmap
          ];

          shellHook = ''
            export GDBINIT_FILE=$(mktemp)
            echo "source ${pkgs.gef}/share/gef/gef.py" > $GDBINIT_FILE
            alias gdb="gdb -x $GDBINIT_FILE"

            echo "RE shell loaded. Tools: gdb+gef, radare2, pwntools, lldb"
          '';
        };
      });
}
