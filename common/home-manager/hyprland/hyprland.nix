{ config, lib, ... }:
let cfg = config.inner.hyprland;
in with lib; {
  imports = [ ./waybar ];

  options.inner.hyprland.enable = mkEnableOption "Enable Hyprland.";

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    wayland.windowManager.hyprland.extraConfig = let
      runOnStart = [
        "fcitx5"
        "waybar"
        "swww init"
        "alacritty"
        "firefox"
        "discord"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
    in ''
      monitor=DP-2,1920x1080@60,0x0,1
      exec-once=${concatStringsSep ("\n" + "exec-once =") runOnStart}

      input {
        kb_layout = br
        kb_variant =
          kb_model =
            kb_options =
              kb_rules =

                follow_mouse = 1

                touchpad {
                  natural_scroll = no
                }

                sensitivity = 0
              }

              general {
                gaps_in = 1
                gaps_out = 0
                border_size = 1
                col.active_border = rgba(eeeeee88) rgba(ffffffbb) 45deg
                col.inactive_border = rgba(000000aa)

                layout = dwindle
              }

              decoration {
                rounding = 0

                blur {
                  enabled = true
                  size = 6
                }

                drop_shadow = yes
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
              }

              animations {
                enabled = yes

                bezier = myBezier, 0.05, 0.9, 0.1, 1.05

                animation = windows, 1, 7, myBezier, popin
                animation = windowsOut, 1, 7, default, slide
                animation = border, 1, 10, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default, fade
              }

              dwindle {
                pseudotile = yes
                preserve_split = yes
              }

              master {
                new_is_master = true
              }

              gestures {
                workspace_swipe = off
              }

              device:epic mouse V1 {
                sensitivity = -0.5
              }

              $mainMod = SUPER

              bind = $mainMod, return, exec, alacritty
              bind = $mainMod, Q, killactive, 
              bind = $mainMod, N, exec, thunar
              bind = $mainMod, space, togglefloating, 
              bind = $mainMod, D, exec, rofi -show run
              bind = $mainMod, P, pseudo,
              bind = $mainMod, O, togglesplit,
              bind = $mainMod, F, fullscreen

              bind = $mainMod, R, submap, resize
              submap = resize

              binde = , right, resizeactive,10 0
              binde = , left, resizeactive,-10 0
              binde = , up, resizeactive,0 -10
              binde = , down, resizeactive,0 10

              bind = , escape, submap, reset
              submap = reset

              bind = $mainMod, left, movefocus, l
              bind = $mainMod, right, movefocus, r
              bind = $mainMod, up, movefocus, u
              bind = $mainMod, down, movefocus, d

              bind = $mainMod, L, movefocus, l
              bind = $mainMod, H, movefocus, r
              bind = $mainMod, K, movefocus, u
              bind = $mainMod, J, movefocus, d
              ${
                concatStringsSep "\n" (genList (i:
                  let
                    kc = toString i;
                    ws = toString (if i == 0 then 10 else i);
                  in ''
                    bind = $mainMod, ${kc}, workspace, ${ws}
                    bind = $mainMod SHIFT, ${kc}, movetoworkspace, ${ws}
                  '') 10)
              }

              ${
                let keyCodes = [ 90 87 88 89 83 84 85 79 80 81 ];
                in concatStringsSep "\n" (genList (i:
                  let
                    kc = toString (elemAt keyCodes i);
                    ws = toString (if i == 0 then 10 else i);
                  in ''
                    bind = $mainMod, ${kc}, workspace, ${ws}
                    bind = $mainMod SHIFT, ${kc}, movetoworkspace, ${ws}
                  '') (length keyCodes))
              }

              bind = $mainMod, mouse_down, workspace, e+1
              bind = $mainMod, mouse_up, workspace, e-1

              bind = , Print, exec, sshot --screen -o $HOME/imgs/screenshots
              bind = SHIFT, Print, exec, sshot --area -o $HOME/imgs/screenshots

              binde = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+
              bindl = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-
              bindl = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

              bindm = $mainMod, mouse:272, movewindow
          # Resize floating windows with Mod+Right-click
          bindm = $mainMod, mouse:273, resizewindow

          windowrule = workspace 2, Vivaldi
          windowrule = workspace 2, firefox 
          windowrule = workspace 3, thunar
          windowrule = workspace 4, Deluge
          windowrule = workspace 4, Okular
          windowrule = workspace 5, discord
          windowrule = workspace 6, krita
          windowrule = workspace 6, Audacity
          windowrule = workspace 7, lutris
          windowrule = workspace 7, Steam
          windowrule = workspace 9, obsidian

          env = QT_QPA_PLATFORM,wayland;xcb
          env = SDL_VIDEODRIVER,wayland
          env = MOZ_ENABLE_WAYLAND,1
          env = WLR_RENDERER_ALLOW_SOFTWARE,1

          env = XDG_CURRENT_DESKTOP,Hyprland
          env = XDG_SESSION_TYPE=wayland
          env = XDG_SESSION_DESKTOP=Hyprland

         # env = GDK_SCALE,2
         env = GDK_BACKEND,wayland,x11
         env = XCURSOR_SIZE,32
    '';
  };
}
