{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./fonts.nix
    ./audio
    ./packages
    ./security
    ./networking
    ./boot
    ../../common/users
  ];

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    # very lazy config
    config = { common = { default = [ "hyprland" "gtk" ]; }; };
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    driSupport = true;
    extraPackages = with pkgs; [ vaapiIntel vaapiVdpau libvdpau-va-gl ];
  };

  environment.shells = with pkgs; [ zsh fish ];
  environment.pathsToLink = [ "/libexec" ];
  services.dbus.enable = true;
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3status ];
    };
    displayManager.lightdm.enable = false;
    xkb.layout = "br";
    videoDrivers = [ "video-intel" "mesa" "vulkan-intel" ];
  };
  # For mice configuration with `piper`.
  services.ratbagd.enable = true;

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

  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "America/Sao_Paulo";
  system.stateVersion = "23.11";
}
