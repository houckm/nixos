{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development tools
    docker-compose
    kubectl

    # IAC
    terraform
    ansible

    # Language servers and compilers
    nil
    yaml-language-server
    haskell-language-server
    ghc
    cabal-install
    claude-code
    clang-tools
    gdb
    gcc
    cmake
    kiro

    # System monitoring & performance
    btop
    fd
    ripgrep
    fzf
    bat
    eza
    zoxide
    ranger
    fastfetch
  ];
}
