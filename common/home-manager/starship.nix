{ ... }: {
  programs.starship = {
    enable = true;
    # enableZshIntegration = true;
    enableFishIntegration = true;
    settings.command_timeout = 3000;
  };
}
