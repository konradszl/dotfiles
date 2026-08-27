{ config, ... }:

{
  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };

    casks = [
      "ghostty"
      "1password"
      "karabiner-elements"
      "raycast"
      "textmate"
      "forklift"
      "hiddenbar"
      "claude"
      "protonvpn"
      "proton-mail"
      "docker-desktop"
      "jetbrains-toolbox"
      "windows-app"
      "microsoft-teams"
      "microsoft-excel"
      "microsoft-azure-storage-explorer"
    ];

    brews = [
      "mas"
      "rbenv"
      "ruby-build"
      "dotnet"
      "freetds"
      "azcopy"
      "azure-cli"
      "curl"
    ];

    masApps = {
      "klack" = 6446206067;
      "easy-csv-editor" = 1171346381;
      "xcode" = 497799835;
      "numbers" = 361304891;
    };
  };  
}
