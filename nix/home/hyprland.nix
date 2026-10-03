{ config, ... }:

{
  xdg.configFile."hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Developer/Personal/github.com/konradszl/dotfiles/config/hypr";
}
