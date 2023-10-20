rec {
  mapToLines =
    (items: map: builtins.concatStringsSep "\n" (builtins.map map items));
  writeMonitors = (monitors:
    mapToLines monitors (monitor:
      "monitor = ${monitor.name},${monitor.resolution},${monitor.position},${monitor.scale}"));
  writeVars =
    (env: mapToLines env (var: "env = ${with var; name + delimiter + value}"));
  writeBinds = (binds:
    mapToLines binds (bind:
      let flags = (if bind.flags == null then "" else bind.flags);
      in "bind${flags} = ${bind.text}"));
  writeWindowRules = (rules:
    mapToLines rules (rule: "windowrule = ${rule.rule},${rule.window}"));
  writeDefaultWorkspaces = (defaultWorkspaces:
    builtins.concatStringsSep "\n" (builtins.attrValues (builtins.mapAttrs
      (workspace: windows:
        mapToLines windows
        (window: "windowrule = workspace ${workspace}, ${window}"))
      defaultWorkspaces)));
  writeOnceStart = (commands:
    "exec-once = "
    + (builtins.concatStringsSep ("\n" + "exec-once = ") commands));
  writeSubmaps = (submaps:
    builtins.concatStringsSep "\n\n" (builtins.attrValues (builtins.mapAttrs
      (submap: binds: ''
        submap = ${submap}
        ${writeBinds binds}
        bind = , escape, submap, reset
      '') submaps)) + "\n" + "submap = reset");
}
