{ ... }:

{
  programs.nushell = {
    enable = true;
    shellAliases = {
      nors = "sudo nixos-rebuild switch";

      l = "ls -la";
      cat = "bat";
      grep = "rg";

      txn = "tmux new";
      txl = "tmux list-sessions";
      txa = "tmux attach -t";

      mic-loop = "pw-loopback";

      vim = "nvim";
      vi = "nvim";
    };
    envFile.text = ''
    $env.config = {
      show_banner: false,
    }
    '';
  };
}
