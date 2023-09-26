{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./packages.nix ./fonts.nix ];

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_5;
  boot.loader.systemd-boot = {
    enable = true;
    # Prevents boot menu from being flooded with entries.
    configurationLimit = 10;
  };
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    driSupport = true;
    extraPackages = with pkgs; [ vaapiIntel vaapiVdpau libvdpau-va-gl ];
  };

  users.users.maya = {
    isNormalUser = true;
    home = "/home/maya";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
  };

  environment.shells = with pkgs; [ zsh nushell ];

  services = {
    dbus.enable = true;
    xserver = {
      layout = "br-abnt2";
      drivers = [ "video-intel" "mesa" "vulkan-intel" ];
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  programs = {
    zsh.enable = true;
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.samba = {
    enable = true;
    openFirewall = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-gtk fcitx5-mozc fcitx5-configtool ];
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart =
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";

    PATH = [ "${XDG_BIN_HOME}" ];
    NIXOS_OZONE_WL = "1";
    GPG_TTY = "$(tty)";
  };

  networking = {
    hostName = "kirisame";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  services.openssh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "tty";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "America/Sao_Paulo";
  system.stateVersion = "23.11";
}
