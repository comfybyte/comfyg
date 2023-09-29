{
  programs.rofi = {
    enable = true;
    theme = "catppuccin-macchiato";
    location = "bottom-right";
  };

  home.file.".local/share/rofi/themes/catppuccin-macchiato.rasi".source =
    ./catppuccin-macchiato.rasi;
}
