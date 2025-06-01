# configuration.nix 
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Desativar IPv6 globalmente para reduzir latência e evitar problemas com provedores que não oferecem suporte adequado
  networking.enableIPv6 = false;
  boot.kernel.sysctl."net.ipv6.conf.all.disable_ipv6" = true;
  boot.kernel.sysctl."net.ipv6.conf.default.disable_ipv6" = true;

  # Configuração de rede
  networking.hostName = "R2-D2";

  # Habilitar NetworkManager para gerenciamento de conexões
  networking.networkmanager.enable = true;

  # Utilizar systemd-resolved para resolução de DNS mais eficiente
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved.enable = true;

  
  networking = {
    wireless.iwd.enable = true;
    wireless.iwd.settings = {
      General = {
        EnableNetworkConfiguration = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };
  # Habilitar iwd (iNet wireless daemon) para melhor desempenho em conexões Wi-Fi
  
  
  hardware.pulseaudio.enable = false;
  # Habilitar PipeWire com suporte a ALSA e PulseAudio
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;  # Descomente se precisar de suporte a JACK
  };

  # Habilitar suporte a Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Configuração adicional para codecs Bluetooth de alta qualidade
  services.pipewire.wireplumber.extraConfig = {
    "bluetooth-enhancements" = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
      };
    };
  };

  

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  time.timeZone = "America/Fortaleza";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS       = "pt_BR.UTF-8";
    LC_IDENTIFICATION= "pt_BR.UTF-8";
    LC_MEASUREMENT   = "pt_BR.UTF-8";
    LC_MONETARY      = "pt_BR.UTF-8";
    LC_NAME          = "pt_BR.UTF-8";
    LC_NUMERIC       = "pt_BR.UTF-8";
    LC_PAPER         = "pt_BR.UTF-8";
    LC_TELEPHONE     = "pt_BR.UTF-8";
    LC_TIME          = "pt_BR.UTF-8";
  };

  console.useXkbConfig = true;
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout  = "br,us";
    options = "grp:alt_shift_toggle,ctrl:swapcaps";
  };
  services.xserver.windowManager.spectrwm.enable = true;

  # Display Manager Ly
  services.displayManager.ly.enable = true;

  # Garante que dbus funcione corretamente para sistema e sessão
  services.dbus.enable = true;

  xdg.portal = {
    enable         = true;
    extraPortals   = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # Gerenciador de chaves, útil para ssh e wifi
  services.gnome.gnome-keyring.enable = true;

  hardware.graphics.enable = true;

  fonts = {
    fontDir.enable     = true;
    fontconfig.enable  = true;
    packages = with pkgs; [
      # meslo-lgs-nf
      nerd-fonts.jetbrains-mono
    ];
  };

  users.users.arthur = {
    isNormalUser = true;
    description  = "arthur";
    extraGroups  = [ "networkmanager" "wheel" ];
    shell        = pkgs.zsh;
    packages     = with pkgs; [];
  };
  programs.zsh.enable = true;

  security.sudo.enable           = true;
  security.sudo.wheelNeedsPassword = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    usbutils slock rofi
    networkmanager xsel
    xsecurelock xautolock
    git curl wget ripgrep fd unzip gnutar
    gcc
    bluez pamixer
  ];

  services.xserver.excludePackages = with pkgs; [ xterm ];

  environment.pathsToLink = [ "/share/terminfo" ];



  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 14d";
  };

  #system.stateVersion = "24.11";
}
 
