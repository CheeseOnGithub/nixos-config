{
    description = "cpp windows";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };
    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs { inherit system; };
                llvm = pkgs.llvmPackages_19;
            in
            {
                devShells.default = pkgs.mkShell {
                    nativeBuildInputs = with pkgs; [
                        llvm.clang-unwrapped
                        llvm.lld
                        llvm.llvm
                        cmake
                        ninja
                        cargo          # needed for xwin
                        rsync
                    ];

                    shellHook = ''
                        export PATH="${llvm.clang-unwrapped}/bin:${llvm.lld}/bin:${llvm.llvm}/bin:$HOME/.cargo/bin:$PATH"
                        export XWIN="''${XWIN:-$HOME/.xwin}"

                        if ! command -v xwin &>/dev/null; then
                            echo "[xwin] not found — installing via cargo..."
                            cargo install xwin --locked
                        fi

                        if [ ! -d "$XWIN/crt" ] || [ ! -d "$XWIN/sdk" ]; then
                            echo "[xwin] SDK not found at $XWIN — running xwin splat..."
                            xwin --accept-license splat --output "$XWIN"
                        fi

                        echo ""
                        echo "  env loaded"
                        echo "  clang-cl : $(which clang-cl)"
                        echo "  lld-link : $(which lld-link)"
                        echo "  xwin SDK : $XWIN"
                        echo ""
                        echo "  configure : cmake -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=toolchain-msvc.cmake"
                        echo "  build     : cmake --build build"
                        echo ""
                    '';
                };
            }
        );
}
