{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      command_timeout = 3000;

      format = lib.concatStrings [
        "[░▒▓](#a3aed2)"
        "[ 󰄛 ](bg:#ffe8db fg:#090c0c)"
        "[](bg:#ffe8db fg:#ffe8db)"
        "$directory"
        "[](fg:#ffe8db bg:#394260)"
        "$git_branch"
        "$git_status"
        "[](fg:#394260 bg:#212736)"
        "$nodejs"
        "$rust"
        "[](fg:#212736 bg:#1d2230)"
        "$time"
        "[ ](fg:#1d2230)"
        "\n$character"
      ];

      directory = {
        style = "fg:#090c0c bg:#ffe8db";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = ".../";
      };

      git_branch = {
        symbol = "";
        style = "bg:#394260";
        format = "[[ $symbol $branch ](fg:#ffe8db bg:#394260)]($style)";
      };

      git_status = {
        style = "bg:#394260";
        format = "[[($all_status$ahead_behind )](fg:#ffe8db bg:#394260)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#ffe8db bg:#212736)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#ffe8db bg:#212736)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#1d2230";
        format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
    };
  };
}
