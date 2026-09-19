{ ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''
      export PATH="$HOME/.rbenv/bin:$PATH"
      eval "$(rbenv init - zsh)"
    '';
    initExtra = ''
      ulimit -S -n 2048
    '';
  };
}
