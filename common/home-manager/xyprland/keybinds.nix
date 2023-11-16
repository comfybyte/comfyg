let
  mkBind = text: {
    inherit text;
    flags = null;
  };
  mkFBind = text: flags: mkBind text // { inherit flags; };
in (map (bind: mkBind bind) [
  "$mod, return, exec, alacritty"
  "$mod, q, killactive, "
  "$mod, space, togglefloating, "
  "$mod, d, exec, rofi -show run"
  "$mod, p, pseudo,"
  "$mod shift, p, pin, "
  "$mod, o, togglesplit,"
  "$mod, f, fullscreen"
  "$mod shift, y, exit,"
  "$mod, left, movefocus, l"
  "$mod, right, movefocus, r"
  "$mod, up, movefocus, u"
  "$mod, down, movefocus, d"
  "$mod, l, movefocus, l"
  "$mod, h, movefocus, r"
  "$mod, k, movefocus, u"
  "$mod, j, movefocus, d"
  "$mod shift, h, swapwindow, l"
  "$mod shift, j, swapwindow, d"
  "$mod shift, k, swapwindow, u"
  "$mod shift, l, swapwindow, r"
  "$mod, mouse_down, workspace, e+1"
  "$mod, mouse_up, workspace, e-1"
  ", Print, exec, sshot --screen -o $HOME/imgs/screenshots"
  "shift, print, exec, sshot --area -o $HOME/imgs/screenshots"
  "$mod, r, submap, resize"
]) ++ [
  (mkFBind
    ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+"
    "le")
  (mkFBind
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"
    "le")
  (mkFBind ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    "le")
  (mkFBind "$mod, mouse:272, movewindow" "m")
  (mkFBind "$mod, mouse:273, resizewindow" "m")
]
