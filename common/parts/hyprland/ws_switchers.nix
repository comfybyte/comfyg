with builtins; ''
  ${concatStringsSep "\n" (genList (i:
    let
      kc = toString i;
      ws = toString (if i == 0 then 10 else i);
    in ''
      bind = $mod, ${kc}, workspace, ${ws}
      bind = $mod SHIFT, ${kc}, movetoworkspace, ${ws}
    '') 10)}

  ${let keyCodes = [ 90 87 88 89 83 84 85 79 80 81 ];
  in concatStringsSep "\n" (genList (i:
    let
      kc = toString (elemAt keyCodes i);
      ws = toString (if i == 0 then 10 else i);
    in ''
      bind = $mod, ${kc}, workspace, ${ws}
      bind = $mod SHIFT, ${kc}, movetoworkspace, ${ws}
    '') (length keyCodes))}
''
