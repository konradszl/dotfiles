{ config, pkgs, ... }:

{
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    neovim
    lazygit
    ripgrep
  ];
  home.sessionVariables = {
    DG_HOME = "${config.home.homeDirectory}/Developer/Work/Dataglide";
  };
  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  xdg.configFile = {
    "ghostty/themes/glimwick-ember".source = ../theme/ghostty/glimwick-ember;
    "ghostty/themes/glimwick-taper".source = ../theme/ghostty/glimwick-taper;
  };

  programs.ghostty = {
    enable = true;
    package = null;
    enableZshIntegration = true;
    settings = {
      theme = "glimwick-ember";
      font-family = "CaskaydiaCove Nerd Font Mono";
      font-style = "Bold";
      font-style-bold = "ExtraBold";
      font-style-italic = "Bold Italic";
      font-style-bold-italic = "ExtraBold Italic";
      font-size = 14;
      background-opacity = 0.95;
      background-blur = true;
      window-padding-x = 10;
      window-padding-y = 10;
      cursor-style = "block";
      cursor-style-blink = true;
      shell-integration-features = "no-cursor";
    };
  };

  programs.zsh = {
    enable = true;
    initContent = ''
      export PATH="$HOME/.rbenv/bin:$PATH"
      eval "$(rbenv init - zsh)"
    '';
  };
}
