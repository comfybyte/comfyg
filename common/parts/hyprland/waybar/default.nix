{ config, lib, ... }:
let cfg = config.parts.hyprland.waybar;
in {
  options.parts.hyprland.waybar = {
    enable = lib.mkEnableOption "Enable Waybar.";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      style = import ./style.nix;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";

          modules-left = [ "clock" "tray" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right =
            [ "network" "cpu" "memory" "temperature" "pulseaudio" ];

          "wlr/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "10" = "10";
            };
          };
          clock = {
            interval = 1;
            format = "{:%a, %e %b @ %H:%M:%S}";
          };
          cpu = {
            interval = 5;
            format = " {usage}%";
            states = {
              warning = 70;
              critical = 90;
            };
          };
          memory = {
            interval = 5;
            format = " {}%";
            states = {
              warning = 70;
              critical = 90;
            };
          };
          pulseaudio = {
            scroll-step = 1;
            format = "󰋋 {volume}%";
            format-muted = "MUT {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";

            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+";
          };
          temperature = {
            thermal-zone = 1;
            hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
            critical-treshold = 70;
            format = "{temperatureC}°C";
            format-critical = "{temperatureC}°C!";
            interval = 60;
          };
          network = {
            interface = "enp2s0";
            interval = 4;
            format = "  {bandwidthDownBytes}   {bandwidthUpBytes}";
          };
          tray = {
            icon-size = 15;
            spacing = 10;
          };
        };
      };
    };
  };
}
