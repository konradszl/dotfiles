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
      "google-chrome"
      "jetbrains-toolbox"
      "windows-app"
      "microsoft-teams"
      "microsoft-excel"
      "microsoft-azure-storage-explorer"
      "corretto@21"
      "corretto@25"
    ];

    brews = [
      "mas"
      "maven"
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

      # Safari extensions
      "1password-for-safari" = 1569813296;
      "ublock-origin-lite" = 6745342698;
      "wappalyzer" = 1520333300;
    };
  };
}
