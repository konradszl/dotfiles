# ❄️ Dotfiles

macOS configuration: [nix-darwin](https://github.com/nix-darwin/nix-darwin) for the
system, [home-manager](https://github.com/nix-community/home-manager) for the user,
[nix-homebrew](https://github.com/zhaofengli/nix-homebrew) for casks and Mac App Store
apps.

Single host: `MacBook` (aarch64-darwin).

## Bootstrap

On a fresh machine, from the top:

```sh
# 1. Install Nix via Lix installer
curl -sSf -L https://install.lix.systems/lix | sh -s -- install

# 2. Clone to this exact path (see Gotchas) 
mkdir -p ~/Developer/Personal/github.com
git clone git@github.com:konradszl/dotfiles.git ~/Developer/Personal/github.com/dotfiles
ln -s ~/Developer/Personal/github.com/dotfiles ~/Developer/Personal/dotfiles # optional

# 3. First switch. darwin-rebuild does not exist yet, so go through nix run
cd ~/Developer/Personal/github.com/dotfiles
nix run nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch --flake .#MacBook
```

Sign in to the Mac App Store before the first switch, or the `masApps` entries fail.

## Daily use

```sh
sudo darwin-rebuild switch --flake .#MacBook # apply changes
nix flake update                             # bump all inputs
nix fmt                                      # format .nix files (nixfmt-tree)
```

The `#MacBook` is optional once the hostname matches; the bare form resolves
the attribute from the hostname.

## Layout

| path               | what                                             |
|--------------------|--------------------------------------------------|
| `flake.nix`        | inputs and the `MacBook` host definition         |
| `nix/darwin.nix`   | system: packages, fonts, hostname, dock defaults |
| `nix/homebrew.nix` | casks, brews, Mac App Store apps                 |
| `nix/home/`        | per-user config, one module per program          |
| `nix/pkgs/`        | local derivations for things not in nixpkgs      |
| `config/`          | raw config files consumed by the modules         |

`config/nvim` and `config/jetbrains/glimwick` are plain source trees. The modules in
`nix/home/` decide how they reach their destinations.

## Gotchas

**The repo path is load-bearing.** `nix/home/neovim.nix` points at
`~/Developer/Personal/github.com/dotfiles/config/nvim` through `mkOutOfStoreSymlink`,
so the nvim config stays editable without a rebuild. Clone anywhere else and nvim comes
up unconfigured with no error. `~/Developer/Personal/dotfiles` is a symlink to the same
place.

**Homebrew is declarative and destructive.** `onActivation.cleanup = "uninstall"` means
anything installed by hand and not listed in `nix/homebrew.nix` is removed on the next
switch. Add it to the file instead.

**Paths in `.nix` files resolve relative to the file, not the flake root.**
`./pkgs/tmc-cli.nix` inside `nix/darwin.nix` means `nix/pkgs/tmc-cli.nix`.

**The JetBrains theme is not built by Nix.** After editing
`config/jetbrains/glimwick/resources/`, rebuild and deploy by hand, then restart the
IDEs:

```sh
cd config/jetbrains/glimwick
jar cf glimwick.jar -C resources META-INF -C resources theme
for d in ~/Library/Application\ Support/JetBrains/*/plugins/glimwick.jar; do
  cp glimwick.jar "$d"
done
```

## Later

- [ ] Package the glimwick JetBrains theme as a derivation in `nix/pkgs/`, deployed into
      each IDE's `plugins/` directory via `home.file`, so it rebuilds on switch instead of
      by hand.
- [ ] Drop `nix/pkgs/tmc-cli.nix` and its entry in `nix/darwin.nix` once the Java MOOC is
      finished.
