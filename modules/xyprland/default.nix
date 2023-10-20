{ config, lib, ... }:
with lib;
let
  cfg = config.programs.xyprland;
  helpers = (import ./helpers.nix);
  customTypes = {
    monitor = types.submodule {
      options = {
        enable = mkEnableOption "Enable this monitor" // { default = true; };
        name = mkOption { type = types.str; };
        resolution = mkOption { type = types.str; };
        position = mkOption { type = types.str; };
        scale = mkOption { type = types.str; };
      };
    };

    var = types.submodule {
      options = {
        name = mkOption { type = types.str; };
        value = mkOption { type = types.str; };
        delimiter = mkOption {
          type = types.str;
          default = "=";
        };
      };
    };

    bind = types.submodule {
      options = {
        flags = mkOption {
          type = with types; nullOr str;
          description =
            "A string of bind flags to add (<https://wiki.hyprland.org/Configuring/Binds/#bind-flags>).";
          default = "";
        };

        text = mkOption {
          type = types.str;
          description = "This bind's contents.";
        };
      };
    };

    windowRule = types.submodule {
      options = {
        rule = mkOption { type = types.str; };
        window = mkOption { type = types.str; };
      };
    };
  };

in {
  options.programs.xyprland = {
    enable = mkEnableOption "Whether to enable this module.";

    xwayland.enable = mkEnableOption "Whether to enable XWayland.";

    mod = {
      key = mkOption {
        type = types.str;
        description =
          "Which key to use as mod. Referenced with $mod by default.";
        default = "SUPER";
      };

      name = mkOption {
        type = types.str;
        default = "mod";
      };
    };

    monitors = mkOption {
      type = types.listOf customTypes.monitor;
      description = "A list of monitor configurations.";
      default = [ ];
    };

    env = mkOption {
      type = types.listOf customTypes.var;
      description = "A list of environment variables.";
      default = [ ];
    };

    binds = mkOption {
      type = types.listOf customTypes.bind;
      description = "A list of keybinds.";
      default = [ ];
    };

    submaps = mkOption {
      type = with types; attrsOf (listOf customTypes.bind);
      description = "A set of submap names mapped to a list of their binds.";
      default = { };
    };

    windowRules = mkOption {
      type = types.listOf customTypes.windowRule;
      description = "A list of window rules.";
      default = [ ];
    };

    defaultWorkspaces = mkOption {
      type = with types; attrsOf (listOf str);
      description =
        "A set of workspace names mapped to lists of window titles.";
      default = { };
    };

    onceStart = mkOption {
      type = with types; listOf str;
      description = "A list of commands to execute on startup, once.";
      default = [ ];
    };

    extraConfig = {
      pre = mkOption {
        type = types.separatedString "\n";
        description = "Lines to add to the start of the configuration file.";
        default = "";
      };
      post = mkOption {
        type = types.separatedString "\n";
        description = "Lines to add to the end of the configuration file.";
        default = "";
      };
    };

    waybar = {
      enable = mkEnableOption "Enable Waybar.";
      style = mkOption {
        type = types.separatedString "\n";
        description = "CSS styling.";
        default = "";
      };
      settings = mkOption {
        type = with types; attrsOf anything;
        default = {};
      };
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = cfg.xwayland.enable;
      extraConfig = with helpers; ''
        ${cfg.extraConfig.pre}

        ${"$" + cfg.mod.name} = ${cfg.mod.key}
        ${writeMonitors cfg.monitors}
        ${writeOnceStart cfg.onceStart}

        ${writeSubmaps cfg.submaps}
        ${writeBinds cfg.binds}

        ${writeVars cfg.env}

        ${writeWindowRules cfg.windowRules}
        ${writeDefaultWorkspaces cfg.defaultWorkspaces}

        ${cfg.extraConfig.post}
      '';
    };

    programs.waybar = cfg.waybar;
  };
}
