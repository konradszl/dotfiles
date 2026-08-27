{ config, pkgs, ... }:

{
  imports = [
    ./ghostty.nix
    ./zsh.nix
  ];

  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    neovim
    lazygit
    ripgrep
  ];

  home.sessionVariables = {
    DG_HOME = "${config.home.homeDirectory}/Developer/Work/Dataglide";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];
}
