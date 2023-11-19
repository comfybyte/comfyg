{ ... }: {
  imports = [ ./waybar ];

  programs.xyprland = let
    mkBind = text: {
      inherit text;
      flags = null;
    };
    mkFlagBind = text: flags: mkBind text // { inherit flags; };
  in {
    enable = true;
    hyprland.xwayland.enable = true;
    enablePortal = true;
    extraConfig.post = import ./ws_switchers.nix;

    options = {
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 4;
        layout = "dwindle";
        "col.active_border" =
          "rgba(22222222) rgba(00000033) rgba(22222222) 45deg";
        "col.inactive_border" = "rgb(000000)";
      };
      input = {
        kb_layout = "br";
        follow_mouse = 1;
      };
      decoration.blur = {
        enabled = true;
        size = 5;
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
    };
    monitors = [[ "DP-2" "1920x1080@60" "0x0" "1" ]];
    env = {
      "QT_QPA_PLATFORM" = "wayland;xcb";
      "SDL_VIDEODRIVER" = "wayland";
      "MOZ_ENABLE_WAYLAND" = "1";
      "WLR_RENDERER_ALLOW_SOFTWARE" = "1";
      "XDG_CURRENT_DESKTOP" = "Hyprland";
      "XDG_SESSION_TYPE" = "wayland";
      "XDG_SESSION_DESKTOP" = "Hyprland";
      "GDK_BACKEND" = "wayland,x11";
      "XCURSOR_SIZE" = "32";
    };

    animation.enable = true;
    animation.animations = [
      "windows, 1, 7, default, slide"
      "windowsOut, 1, 7, default, slide"
      "border, 1, 10, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default, fade"
    ];

    defaultWorkspaces = let
      mkSilent = text: {
        inherit text;
        silent = true;
      };
    in {
      "2" = [ "firefox" ];
      "3" = [ "Thunar" ];
      "4" = [ (mkSilent "Okular") (mkSilent "title:^Deluge$") ];
      "5" = [ (mkSilent "discord") ];
      "6" = [ "Audacity" "krita" ];
      "7" = [ (mkSilent "lutris") (mkSilent "title:^Steam$") ];
      "9" = [ (mkSilent "title:^(.*)- Obsidian(.*)$") ];
    };
    binds = import ./keybinds.nix;

    submaps = {
      resize = map (bind: mkFlagBind bind "e") [
        ", l, resizeactive, 12 0"
        ", h, resizeactive, -12 0"
        ", k, resizeactive, 0 -12"
        ", j, resizeactive, 0 12"
        ", right, resizeactive, 12 0"
        ", left, resizeactive, -12 0"
        ", up, resizeactive, 0 -12"
        ", down, resizeactive, 0 12"
        ", q, submap, reset"
      ];
    };

    windowRules = { float = [ "title:^(.*)Library(.*)$" ]; };

    onceStart = [
      "fcitx5"
      "waybar"
      "swww init"
      "alacritty -e tmux new"
      "firefox"
      "discord"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    ];
  };
}
