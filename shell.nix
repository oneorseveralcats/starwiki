{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [
    goldendict-ng
    kiwix
    libzim
    pyglossary
  ];

  shellHook = ''
    LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib

    if [ -e ./create_venv.sh ] && [ ! -e ./.venv ]; then
      ./create_venv.sh
    fi
  '';
}

