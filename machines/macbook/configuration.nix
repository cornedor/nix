{
  pkgs,
  lib,
  ...
}: {
  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.settings.trusted-users = [
    "@admin"
  ];
  nix.configureBuildUsers = true;
  documentation.enable = false;

  users.users = {
    corne = {
      home = "/Users/corne";
    };
  };

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions =
    ''
      auto-optimise-store = false
      experimental-features = nix-command flakes
    ''
    + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  # ZSH is enabled in home
  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    ## GUI Programs
    # vscodeWithExtensions
    # nil #dependency for vscode extension
    postman
    charles
  ];

  programs.nix-index.enable = true;

  # Fonts
  # fonts.enableFontDir = true;
  # fonts.fonts = with pkgs; [
  #    recursive
  #    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  #  ];

  # Keyboard
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.defaults = {
    screencapture.location = "~/Screenshots";

    dock."mru-spaces" = false;

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      _FXShowPosixPathInTitle = false;
      # _FXSortFoldersFirst = true;
      FXDefaultSearchScope = "SCcf";
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    NSGlobalDomain = {
      KeyRepeat = 1;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      ApplePressAndHoldEnabled = false;
      AppleShowAllExtensions = true;
      AppleKeyboardUIMode = 3; # Navigate trough all UI elements using keyboard
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
