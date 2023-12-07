{
  programs.nixvim.plugins = {
    nix.enable = true;
    leap.enable = true;
    surround.enable = true;
    fugitive.enable = true;
    presence-nvim = {
      enable = false;
      mainImage = "file";
      neovimImageText = "🌙";
      editingText = "Editing";
      readingText = "Reading";
      workspaceText = "In project";
      fileExplorerText = "In menu";
      gitCommitText = "In Git menu";
      showTime = false;
      extraOptions.buttons = false;
    };
    markdown-preview.enable = true;
    comment-nvim.enable = true;
    nvim-autopairs = {
      enable = true;
      disabledFiletypes = [ "clj" ];
    };
    ts-autotag.enable = true;
    trouble.enable = true;
  };
}
