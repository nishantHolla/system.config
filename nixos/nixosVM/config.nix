## system config for nixosVM
{ config, lib, pkgs, ... }:

{
  # GRUB Boot Loader
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixosVM";
  networking.networkmanager.enable = true;

  # Time Zone
  time.timeZone = "Asia/Kolkata";

  # Network Proxy
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # X11
  services.xserver.enable = true;
  services.xserver.resolutions = [ { x = 1920; y = 1080; } ];
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Printing
  services.printing.enable = true;

  # Sound
  services.pulseaudio.enable = true;
  services.pipewire.enable = false;

  # Touchpad
  services.libinput.enable = true;

  # Programs
  programs.zsh.enable = true;
  security.pam.services.i3lock = {};

  # Users
  users.users.nishant = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  # SUID Wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services
  services.openssh.enable = true;

  # Firewall
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 433 ];
  networking.firewall.allowedUDPPorts = [ ];

  # Other settings
  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

#
# Notes:
#
# Upgrade system: https://nixos.org/manual/nixos/stable/#sec-upgrading
#
