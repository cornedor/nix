{ config, pkgs, lib, ... }:
{
  home.stateVersion = "23.05";

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  imports = [
    ./shared/vscode.nix
    ./shared/git.nix
    ./shared/zsh.nix
  ];

  home.packages = with pkgs; [
    # Some basics
    coreutils
    curl
    wget
    htop
    neovim
    git
    bit
    openssl
    gnupg
    ffmpeg
    irssi
    yaml2json
    jq
    gnused
    thefuck
    dig
    graalvm19-ce

    # Virtualisation
    colima
    docker
    openssh

    ## JavaScript Development
    nodejs
    # nodejs-12_x
    yarn
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.create-react-app
    deno

    ## PHP Development
    mysql
    php82Packages.composer
    php82
    mkcert
    nss
    nssTools
    caddy
    # Other languages
    go
    haxe
    # hashlink
    clang
    opam
    micromamba

    # Useful nix related tools
    nixpkgs-fmt
    nil
    # cachix # adding/managing alternative binary caches hosted by Cachix
    nodePackages.node2nix
    comma
  ] ++ lib.optionals stdenv.isDarwin [
    m-cli # useful macOS CLI commands
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

    # Alias
  home.shellAliases.gitappend = "git commit --amend --no-edit && git push --force-with-lease";
  home.shellAliases.vim = "nvim";

  # home.file.".envrc".source 
}
