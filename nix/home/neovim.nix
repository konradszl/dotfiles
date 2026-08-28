{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    sideloadInitLua = true;
    extraPackages = with pkgs; [
      tree-sitter
    ];
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Developer/Personal/github.com/dotfiles/config/nvim";
}
