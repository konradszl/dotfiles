{ ... }:

{
  xdg.configFile = {
    "ghostty/themes/glimwick-ember".source = ../../config/ghostty/themes/glimwick-ember;
    "ghostty/themes/glimwick-taper".source = ../../config/ghostty/themes/glimwick-taper;
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
}
