{
  config,
  pkgs,
  lib,
  ...
}: {
  home.stateVersion = "23.11";

  imports = [
    ../shared/vscode.nix
    ../shared/git.nix
    ../shared/zsh.nix
    ../shared/htop.nix
    # ../shared/alacritty.nix
  ];

  home.packages = with pkgs;
    [
      # Some basics
      coreutils
      killall
      curl
      wget
      htop
      gnutar
      ripgrep
      neovim
      tmux
      git
      bit
      openssl
      gnupg
      ffmpeg
      irssi
      screen
      yaml2json
      jq
      gnused
      dig
      fd
      android-tools

      # Replace MacOS packages
      gnumake

      obsidian

      # Virtualisation
      docker
      openssh

      ## JavaScript Development
      nodejs
      bun
      # nodejs-12_x
      yarn
      nodePackages.eslint
      nodePackages.prettier
      nodePackages.yalc
      turbo
      deno

      ## PHP Development
      mysql
      php82
      php82Packages.composer
      mkcert
      nss
      nssTools
      caddy

      # Other languages
      go
      haxe
      # clang_16
      # hashlink
      # clang
      # gcc
      # opam
      ocamlPackages.ocaml-lsp
      ocamlPackages.utop
      ocamlPackages.odoc
      ocamlPackages.ocamlformat
      dune_3
      micromamba
      jdk17
      erlang_26
      python311
      python311Packages.pip
      cargo
      rustc
      gleam

      # Useful nix related tools
      nixpkgs-fmt
      nil
      # cachix # adding/managing alternative binary caches hosted by Cachix
      nodePackages.node2nix
      nodePackages.typescript-language-server
      vscode-langservers-extracted
      comma
    ]
    ++ lib.optionals stdenv.isDarwin [
      m-cli # useful macOS CLI commands
      lima
      colima
    ]
    ++ lib.optionals stdenv.isLinux [
      _1password
      _1password-gui
      openmw
      tailscale
      mullvad-vpn
      transmission-gtk
      barrier
      libreoffice
      # Currently broken or has quirks in MacOS
      firefox
      blender
      vlc
      prismlauncher
    ];

  programs = {
    yazi.enable = true;
  };

  home.sessionPath = ["$HOME/.local/bin"];

  # Alias
  home.shellAliases.gitappend = "git commit --amend --no-edit && git push --force-with-lease";
  home.shellAliases.vim = "nvim";

  # manual.manpages.enable = false;

  # home.file.".envrc".source
}
