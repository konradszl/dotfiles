{ ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''
      export PATH="$HOME/.rbenv/bin:$PATH"
      eval "$(rbenv init - zsh)"
    '';
  };
}
