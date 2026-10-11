{ ... }:

{
  programs.ssh = {
    enable = true;
    settings."github.com" = {
      IdentityFile = "~/.ssh/github";
      AddKeysToAgent = true;
    };
  };
}
