# configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # NÃO colocar aqui `inputs.home-manager.nixosModules.default`
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "R2-D2";
  networking.networkmanager.enable = true;

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
    kitty picom feh btop slock rofi
    zsh zsh-powerlevel10k networkmanager xsel
    firefox xsecurelock xautolock
    neovim lua git curl wget ripgrep fd unzip gnutar
    nodejs yarn
    python3 python3Packages.pip python3Packages.black python3Packages.ruff python3Packages.debugpy
    pyright
    rustc cargo clippy rustfmt lldb rust-analyzer gcc
  ];

  services.xserver.excludePackages = with pkgs; [ xterm ];

  environment.pathsToLink = [ "/share/terminfo" ];



  nix.gc = {
    automatic = true;
    dates     = "monthly";
    options   = "--delete-older-than 30d";
  };

  system.stateVersion = "24.11";
}
 
