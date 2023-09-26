{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    plugins = with pkgs; [
      {
        name = "fzf-fish";
        src = fishPlugins.fzf-fish;
      }
      {
        name = "forgit";
        src = fishPlugins.forgit;
      }
    ];

    shellAliases = {
      nors = "sudo nixos-rebuild switch";

      txn = "tmux new";
      txl = "tmux list-sessions";
      txa = "tmux attach -t";

      ls = "eza";
      la = "eza -a";
      tree = "eza -T";
      cat = "bat";

      vim = "nvim";
      vi = "nvim";
    };
  };
}
