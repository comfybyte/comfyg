{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  wayland.windowManager.hyprland.extraConfig = 
  let
    homeDir = config.home.homeDirectory;
  in ''
    monitor=DP-2,1920x1080@60,0x0,1
    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = fcitx5
    # exec-once = waybar
    exec-once = eww daemon && eww open system-bar
    exec-once = swww init
    exec-once = alacritty

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
        gaps_in = 0
        gaps_out = 0
        border_size = 0
        col.active_border = rgba(d14ef2ee) rgba(b03cdeee) 45deg
        col.inactive_border = rgba(ffc9cf44)
    
        layout = dwindle
    }
    
    decoration {
        rounding = 5
        blur = yes
        blur_size = 4
        blur_passes = 1
        blur_new_optimizations = on
    
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
        animation = workspaces, 1, 6, default, slide
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
    bind = $mainMod, D, exec, ulauncher
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
    
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10
    
    
    # Numpad keys.
    bind = $mainMod, 87, workspace, 1
    bind = $mainMod, 88, workspace, 2
    bind = $mainMod, 89, workspace, 3
    bind = $mainMod, 83, workspace, 4
    bind = $mainMod, 84, workspace, 5
    bind = $mainMod, 85, workspace, 6
    bind = $mainMod, 79, workspace, 7
    bind = $mainMod, 80, workspace, 8
    bind = $mainMod, 81, workspace, 9
    bind = $mainMod, 90, workspace, 10
    
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10
    
    bind = $mainMod SHIFT, 87, movetoworkspace, 1
    bind = $mainMod SHIFT, 88, movetoworkspace, 2
    bind = $mainMod SHIFT, 89, movetoworkspace, 3
    bind = $mainMod SHIFT, 83, movetoworkspace, 4
    bind = $mainMod SHIFT, 84, movetoworkspace, 5
    bind = $mainMod SHIFT, 85, movetoworkspace, 6
    bind = $mainMod SHIFT, 79, movetoworkspace, 7
    bind = $mainMod SHIFT, 80, movetoworkspace, 8
    bind = $mainMod SHIFT, 81, movetoworkspace, 9
    bind = $mainMod SHIFT, 90, movetoworkspace, 10
    
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1
    
    bind = ,Print, exec, ${homeDir}/scripts/ss_area.sh
    bind = SHIFT, Print, exec, ${homeDir}/scripts/ss_screen.sh
    
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
    windowrule = workspace 5, discord
    windowrule = workspace 6, krita
    windowrule = workspace 6, Audacity
    windowrule = workspace 7, lutris

    env = QT_QPA_PLATFORM,wayland;xcb
    env = SDL_VIDEODRIVER,wayland
    env = MOZ_ENABLE_WAYLAND,1
    env = WLR_RENDERER_ALLOW_SOFTWARE,1

    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE=wayland
    env = XDG_SESSION_DESKTOP=Hyprland

   # env = GDK_SCALE,2
    env = XCURSOR_SIZE,32
  '';
}
