{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    sideloadInitLua = true;

    extraPackages = with pkgs; [
      tree-sitter

      # Language servers
      gopls
      basedpyright
      vtsls
      nixd
      lua-language-server

      # Formatters and linters, driven by conform.nvim
      ruff
      stylua
    ];
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Developer/Personal/github.com/dotfiles/config/nvim";
}
