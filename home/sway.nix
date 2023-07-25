{ config, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
    };
    config = rec {
      modifier = "Mod4";
      input = {
        "*" = {
          xkb_layout = "br";
        };
      };
      terminal = "alacritty";
      menu = "ulauncher";
      startup = [ 
        { command = "fcitx5"; }
        { command = "swww init"; }
        { command = "alacritty"; }
        { command = "sleep 10 && discord"; }
      ];

      gaps = {
        smartBorders = "no_gaps";
        smartGaps = true;
      };
      window.titlebar = false;

      keybindings = 
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
        homeDir = config.home.homeDirectory;
      in lib.mkOptionDefault {
        "${modifier}+q" = "kill";
        "${modifier}+n" = "exec thunar";
        "print" = "exec ${homeDir}/scripts/ss_area.sh ";
        "shift+print" = "exec ${homeDir}/scripts/ss_screen.sh ";

        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };

      assigns =  {
        "2" = [
          { class = "Vivaldi"; app_id = "Vivaldi"; }
        ];
        "3" = [
          { app_id = "thunar"; }
        ];
        "5" = [
          { class = "Discord"; app_id = "Discord"; }
        ];
        "6" = [
          {
            class = "krita";
            app_id = "krita";
          }
          {
            class = "Audacity";
            app_id = "Audacity";
          }
        ];
        "9" = [
          {
            class = "obsidian";
            app_id = "obsidian";
          }
          {
            class = "Insomnia";
            app_id = "insomnia";
          }
        ];
      };

      bars = [
        { 
          command = "waybar";
          position = "top";
        }
      ];

      workspaceAutoBackAndForth = true;
      focus.mouseWarping = false;

    };
    extraSessionCommands = ''
    export XDG_CURRENT_DESKTOP=sway
    export MOZ_ENABLE_WAYLAND=1
    export XDG_SESSION_TYPE=wayland
    export WLR_NO_HARDWARE_CURSORS=1
    export WLR_RENDERER_ALLOW_SOFTWARE=1
    export QT_QPA_PLATFORM=wayland
    export SDL_VIDEODRIVEVER=wayland
    '';
    extraConfig = ''
    exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
    exec hash dbus-update-activation-environment 2>/dev/null && \
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
    '';
  };
}
