{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  services.ssh-agent.enable = true;

  home.packages = with pkgs; [
    hyprlauncher
  ];
}
