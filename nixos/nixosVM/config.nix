## system config for nixosVM
{ config, lib, pkgs, ... }:

{
    # Boot Loader
    boot.loader.grub.enable = true;
    boot.loader.grub.devices = [ "nodev" ];
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.configurationLimit = 7;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking
    networking.hostName = "nixosVM";
    networking.networkmanager.enable = true;

    # Time Zone
    time.timeZone = "Asia/Kolkata";

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
    security.rtkit.enable = true;

    # Touchpad
    services.libinput.enable = true;

    # Bluetooth

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket";
    services.blueman.enable = true;

    # Programs
    programs.zsh.enable = true;
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;

    # Virtualization
    virtualisation.docker.enable = true;
    virtualisation.podman.enable = true;

    # Users
    users.users.guest = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "podman"
            "docker"
            "tailscale"
            "bluetooth"
        ];
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
    services.udisks2.enable = true;
    services.tailscale.enable = true;

    # Firewall
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [
        22  # SSH
        80  # HTTP
        443 # HTTPS
    ];
    networking.firewall.allowedUDPPorts = [
        config.services.tailscale.port
    ];
    networking.firewall.trustedInterfaces = [ "tailscale0" ];

    # Garbage collection
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 15d";

    nix.optimise.automatic = true;
    nix.optimise.dates = "weekly";

    # Other settings
    system.stateVersion = "25.05";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

#
# Notes:
#
# Upgrade system: https://nixos.org/manual/nixos/stable/#sec-upgrading
#
