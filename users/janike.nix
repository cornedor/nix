{pkgs, ...}: {
  home.stateVersion = "23.05";

  imports = [
    ../shared/zsh.nix
  ];

  home.packages = with pkgs; [
    coreutils
    curl
    wget
    graalvm19-ce
    libreoffice
    google-chrome
    firefox
    prismlauncher
  ];
}
