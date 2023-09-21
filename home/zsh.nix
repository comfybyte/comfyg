{ config, lib, ... }: 

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      nors = "sudo nixos-rebuild switch";

      txn = "tmux new";
      txl = "tmux list-sessions";
      txa = "tmux attach -t";

      ls = "exa";
      la = "exa -a";
      tree = "exa -T";
      cat = "bat";
      grep = "rg";

      mic-loop = "pw-loopback";

      vim = "nvim";
      vi = "nvim";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      theme = "intheloop";
      plugins = [
        "git"
        "rust"
      ];
    };
    syntaxHighlighting.enable = true;
    initExtra = lib.concatStrings [
      "bindkey '^b' history-incremental-pattern-search-backward"
    ];
  };
}
