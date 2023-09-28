{ pkgs, ... }: {
  home.packages = with pkgs.fishPlugins; [
    fzf-fish
    forgit
    autopair
    puffer # Auto-expanding.
  ];

  programs.fish = {
    enable = true;

    shellAbbrs = {
      nors = "sudo nixos-rebuild switch";

      txn = "tmux new";
      txl = "tmux list-sessions";
      txa = "tmux attach -t";
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
}
