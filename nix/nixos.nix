{ self, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Thinkpad";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  services.libinput.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  users.users.konrad = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    claude-code
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05";
  system.configurationRevision = self.rev or self.dirtyRev or null;
}
