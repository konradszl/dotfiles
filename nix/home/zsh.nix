{ ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''
      export PATH="$HOME/.rbenv/bin:$PATH"
      eval "$(rbenv init - zsh)"
      ulimit -S -n 2048
    '';
  };
}
