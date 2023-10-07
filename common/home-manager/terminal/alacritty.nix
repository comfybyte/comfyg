{ config, lib, ... }:
let cfg = config.inner.alacritty;
in with lib; {
  options.inner.alacritty.enable = mkEnableOption "Enable alacritty.";

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.75;
        };
        draw_bold_text_with_bright_colors = true;
        custom_cursor_colors = true;
        font = let font = "FixedsysExcelsior Nerd Font";
        in {
          size = 16;
          normal.family = "${font}";
          bold.family = "${font}";
          italic.family = "${font}";
          bold_italic.family = "${font}";
        };
        colors = {
          primary = {
            background = "0x000000";
            foreground = "0xcbe1e7";
          };
          cursor = {
            text = "0xff271d";
            cursor = "0xfbfcfc";
          };
          normal = {
            black = "0x141228";
            red = "0xff5458";
            green = "0x62d196";
            yellow = "0xffb378";
            blue = "0x65b2ff";
            magenta = "0x906cff";
            cyan = "0x63f2f1";
            white = "0xa6b3cc";
          };
          bright = {
            black = "0x565575";
            red = "0xff8080";
            green = "0x95ffa4";
            yellow = "0xffe9aa";
            blue = "0x91ddff";
            magenta = "0xc991e1";
            cyan = "0xaaffe4";
            white = "0xcbe3e7";
          };
        };
      };
    };
  };
}
