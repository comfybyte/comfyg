{ config, lib, ... }:
let
  cfg = config.inner.git;
  name = "comfybyte";
  email = "comfybyte@proton.me";
in with lib; {
  options.inner.git.enable = mkEnableOption "Enable git.";

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = name;
      userEmail = email;
      signing = {
        signByDefault = true;
        key = "61143F72A8F3440A";
      };
      extraConfig = {
        core.editor = "vim";
        init.defaultBranch = "main";
        push.default = "current";
      };
    };
  };
}
