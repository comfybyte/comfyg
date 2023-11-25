{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./fonts.nix
    ./security.nix
    ./packages
    ../../common/users
  ];

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 1048576;
  boot.kernel.sysctl."kernel.sysrq" = 1;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    driSupport = true;
    extraPackages = with pkgs; [ vaapiIntel vaapiVdpau libvdpau-va-gl ];
  };

  environment.shells = with pkgs; [ zsh fish nushell ];

  environment.pathsToLink = [ "/libexec" ];

  services.dbus.enable = true;
  services.flatpak.enable = true;
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3status ];
    };
    displayManager.lightdm.enable = false;
    layout = "br";
    videoDrivers = [ "video-intel" "mesa" "vulkan-intel" ];
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.samba = {
    enable = true;
    openFirewall = true;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-mozc
      fcitx5-hangul
      libsForQt5.fcitx5-qt
    ];
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

  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "America/Sao_Paulo";
  system.stateVersion = "23.11";
}
