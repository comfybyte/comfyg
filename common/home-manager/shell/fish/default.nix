{ pkgs, config, lib, ... }:
let cfg = config.inner.fish;
in with lib; {
  options.inner.fish.enable = mkEnableOption "Enable fish.";

  config = mkIf cfg.enable {
    home.packages = with pkgs.fishPlugins; [
      fzf-fish
      forgit
      autopair
      puffer
    ];

    programs.fish = {
      enable = true;

      shellAbbrs = {
        nors = "sudo nixos-rebuild switch";

        txn = "tmux new";
        txl = "tmux list-sessions";
        txa = "tmux attach -t";

        ga = "git add";
        gs = "git status";
        gc = "git commit -m";
      };

      shellAliases = {
        ls = "eza";
        la = "eza -a";
        tree = "eza -T";
        cat = "bat";

        vim = "nvim";
        vi = "nvim";
      };

      shellInit = ''
        set -g fish_greeting "<<< Welcome, $(whoami). >>>"

        direnv hook fish | source
      '';
    };

    home.file.".config/fish/themes/catppuccin_macchiato.theme".source =
      ./catpuccin_macchiato.theme;
  };
}
