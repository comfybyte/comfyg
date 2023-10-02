{ lib, config, ... }:
let cfg = config.inner.zsh;
in with lib; {
  options.inner.zsh.enable = mkEnableOption "Enable zsh.";

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
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
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        theme = "intheloop";
        plugins = [ "git" "rust" "direnv" ];
      };
      syntaxHighlighting.enable = true;
      initExtra = lib.concatStrings [
        # Rebinding since I use ^s as my tmux prefix.
        "bindkey '^b' history-incremental-pattern-search-backward"
      ];
    };
  };
}
