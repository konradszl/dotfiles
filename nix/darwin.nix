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
}
