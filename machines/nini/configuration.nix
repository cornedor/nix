# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "iommu=pt" ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/var/mnt/data" =
    {
      device = "/dev/sda2";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "big_writes" ];
    };

  networking.hostName = "nini"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us,us";
    xkbOptions = "caps:swapescape,lv3:ralt_switch";
    xkbVariant = "altgr-intl";
    videoDrivers = [ "nvidia" ];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  hardware.nvidia.modesetting.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  #

  services.mullvad-vpn.enable = true;

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.corne = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "docker" "adbusers" ]; # Enable ‘sudo’ for the user.
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.janike = {
    isNormalUser = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    killall
    pciutils
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    screen
    inotify-tools
    ffmpeg
    blender

    tailscale
    mullvad-vpn
    transmission-gtk
    barrier
    libreoffice
    vlc

    ## Gnome/theming
    gnome.gnome-tweaks
    gnome.gnome-shell-extensions
    gnomeExtensions.user-themes
    gnomeExtensions.removable-drive-menu
    arc-theme
    ibm-plex

    # Virtualisation
    virt-manager
    podman-compose

    # Development
    haxe
    php81Packages.composer
    php
    python
    pkg-config
    lz4
    mono
    gcc
    go
    elixir
    erlang

    # Gaming
    protontricks
    dosbox
    openjdk

  ];

  programs.steam.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  fonts.fonts = with pkgs; [
    ibm-plex
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      ovmf = {
        enable = true;
      };
      swtpm = {
        enable = true;
      };
    };
  };

  systemd.services.libvirtd = {
    path = with pkgs; [ libvirt procps utillinux doas ];
  };

  virtualisation.docker.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  # Torrents
  services.radarr.enable = true;
  services.sonarr.enable = true;
  services.bazarr.enable = true;
  services.prowlarr.enable = true;

  location.latitude = 52.0;
  location.longitude = 5.5;

  services.redshift = {
    enable = true;
    brightness = {
      day = "1";
      night = "1";
    };
    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  services.tailscale.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 57220 25565 ];
  networking.firewall.allowedUDPPorts = [ 57220 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
