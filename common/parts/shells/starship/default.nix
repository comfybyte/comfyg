{ config, lib, ... }: 
let cfg = config.parts.shells.starship; in
{
  options.parts.shells.starship.enable = lib.mkEnableOption "Enable Starship.";

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        command_timeout = 3000;
        format = "$username$hostname$directory$nix_shell$character";
        add_newline = false;
        username = {
          show_always = true;
          format = "\\[[$user]($style)@";
          style_user = "bold cyan";
          style_root = "bold bright-red";
        };
        hostname = {
          ssh_only = false;
          style = "bold bright-purple";
          format = "[$hostname]($style)\\]";
        };
        directory = {
          format = " <[$path]($style)[$read_only]($read_only_style)>";
          read_only = " <no touchie!>>";
          truncation_length = 2;
        };
        nix_shell = {
          format = " [$state( \($name\))]($style)";
        };
      };
    };
  };
}
