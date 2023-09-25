{ ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings.command_timeout = 3000;
  };
}
