{ config, lib, ... }:
let cfg = config.parts.git;
in {
  options.parts.git = {
    enable = lib.mkEnableOption "Enable git.";
    name = lib.mkOption { type = lib.types.str; };
    email = lib.mkOption { type = lib.types.str; };
    key = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      signing = {
        signByDefault = true;
        key = cfg.key;
      };
      extraConfig = {
        core.editor = "vim";
        init.defaultBranch = "main";
        push.default = "current";
        merge.conflictStyle = "diff3";
      };
    };
  };
}
