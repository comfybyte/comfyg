{ config, lib, ... }:
let cfg = config.inner.hyprland;
in with lib; {
  options.inner.hyprland.waybar =
    mkEnableOption "Enable Waybar configured for Hyprland.";

  config = mkIf cfg.waybar {
    programs.waybar = {
      enable = true;

      style = builtins.readFile ./style.css;

      settings = {
        mainBar = {
          layer = "bottom";
          position = "top";
          modules-left = [ "hyprland/workspaces" ];
          modules-right = [
            "network"
            "cpu"
            "memory"
            "temperature"
            "pulseaudio"
            "tray"
            "clock"
          ];

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
            format = "{:%H:%M:%S (%e %b %Y / %a)}";
          };

          cpu = {
            interval = 5;
            format = "  {usage}%";
            states = {
              warning = 70;
              critical = 90;
            };
          };

          memory = {
            interval = 5;
            format = "󰍛  {}%";
            states = {
              warning = 70;
              critical = 90;
            };
          };

          pulseaudio = {
            scroll-step = 1;
            format = "󰕾  {volume}%";
            format-muted = "󰝟 {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";

            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-";
          };

          temperature = {
            thermal-zone = 1;
            hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
            critical-treshold = 80;
            format = "{temperatureC}󰔄";
            format-critical = "{temperatureC}°C!";
            interval = 60;
          };

          network = {
            interface = "enp2s0";
            interval = 2;
            format = "{bandwidthUpBytes}    {bandwidthDownBytes} ";
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
