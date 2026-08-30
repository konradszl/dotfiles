{ self, pkgs, ... }:

{
  users.users.konrad = {
    name = "konrad";
    home = "/Users/konrad";
  };

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  nix.settings.experimental-features = "nix-command flakes";

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  system.primaryUser = "konrad";

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Dock settings
  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-delay = 0.01;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.persistent-apps = [
    { app = "/Applications/Claude.app"; }
    { app = "/Applications/Ghostty.app"; }
  ];
  system.defaults.dock.persistent-others = [
    { folder = "/Users/konrad/Downloads"; }
  ];
}
