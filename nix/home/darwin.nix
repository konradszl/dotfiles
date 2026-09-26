{ config, ... }:

{
  programs.zsh = {
    initContent = ''
      export PATH="$HOME/.rbenv/bin:$PATH"
      eval "$(rbenv init - zsh)"
      ulimit -S -n 2048
    '';
  };

  programs.ghostty = {
    package = null;
  };

  home.sessionVariables = {
    DG_HOME = "${config.home.homeDirectory}/Developer/Work/Dataglide";
  };
}
