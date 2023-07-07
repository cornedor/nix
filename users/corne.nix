{
  config,
  pkgs,
  lib,
  ...
}: {
  home.stateVersion = "23.05";

  imports = [
    ../shared/vscode.nix
    ../shared/git.nix
    ../shared/zsh.nix
    ../shared/htop.nix
  ];

  home.packages = with pkgs;
    [
      # Some basics
      coreutils
      killall
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
      screen
      yaml2json
      jq
      gnused
      thefuck
      dig
      # graalvm19-ce

      obsidian

      # Virtualisation
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
      jdk17

      # Useful nix related tools
      nixpkgs-fmt
      nil
      # cachix # adding/managing alternative binary caches hosted by Cachix
      nodePackages.node2nix
      comma
    ]
    ++ lib.optionals stdenv.isDarwin [
      m-cli # useful macOS CLI commands
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

  home.sessionPath = ["$HOME/.local/bin"];

  # Alias
  home.shellAliases.gitappend = "git commit --amend --no-edit && git push --force-with-lease";
  home.shellAliases.vim = "nvim";

  # manual.manpages.enable = false;

  # home.file.".envrc".source
}
