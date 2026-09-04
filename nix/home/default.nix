{ config, pkgs, ... }:

{
  imports = [
    ./ghostty.nix
    ./zsh.nix
    ./neovim.nix
  ];

  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    uv
    nodejs
    pnpm
    fd
    lazygit
    lazydocker
    dive
    ripgrep
  ];

  programs.go = {
    enable = true;
    env = {
      GOPATH = "${config.home.homeDirectory}/Developer/SDKs/go";
      GOBIN = "${config.home.homeDirectory}/.local/bin";
    };
  };

  programs.direnv.enable = true;

  home.sessionVariables = {
    DG_HOME = "${config.home.homeDirectory}/Developer/Work/Dataglide";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];
}
