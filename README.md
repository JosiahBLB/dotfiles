## Manual Configuration

### Nix Installation
1. (Ubuntu) Install curl and git `sudo apt install curl; sudo apt install git` 
2. (All) Use [determinate systems installer](https://github.com/DeterminateSystems/nix-installer) to install the Nix package manager
3. (MacOS) Install [nix-darwin](https://github.com/LnL7/nix-darwin) which provides access to MacOS system settings
4. (All) Install [home-manager](https://nix-community.github.io/home-manager/#sec-install-standalone) standalone version

### Using this Flake
Linux: `home-manager switch --flake github:JosiahBLB/dotfiles#linuxHome`\
MacOS: `darwin-rebuild switch --flake github:JosiahBLB/dotfiles#genericDarwin`

Alternatively for development you can use:\
`<cmd> build --flake .#<derivation>` or\
`<cmd> switch --flake .#<derivation>` 

### Zsh (Linux)
After running home-manager, to set linux to your default shell you need to:
1. Add the output of `which zsh` to `/etc/shells`
2. Run `chsh -s "$(which zsh)"; sudo reboot`

### Iterm2 (MacOS)
- Importing colors using `Profiles > Colors > Color > Color Presets... > Import...` 
- Setting compatible terminal keymappings using `Profiles > Keys > Key Mappings > Presets... > Natural Text Editing`
- Un-setting `Apps can change how keys are reported` in `Profiles > Keys > General`
- Setting `Left Option key` to `Esc+` in `Profiles > Keys > General` ([source](https://github.com/helix-editor/helix/issues/2280#issuecomment-1165542932))
- Setting `Applications in terminal may access clipboard` in `General > Selection` ([source](https://github.com/helix-editor/helix/issues/8715))
- Setting font to `JetBrainsMono Nerd Font Mono` with font size 14

## Issues
- I accidentally reset (`⌘-R`) iterm2 and lost the ability to run binaries. This was fixed by temporarily adding the following to \$PATH `export PATH="$PATH:/run/current-system/sw/bin"` and then running `darwin-rebuild switch --flake .` again

## Useful Commands

Used the following command to get the latest nixpkgs where `<input>` was `nixpkgs`. This can be used for any of your flake inputs to update your flake.lock file.
```sh
nix flake lock --update-input <input>
```

## Helpful Nix Related Links
### Nix Programming
[Introduction to Nix programming](https://nixcloud.io/tour/?id=introduction/nix)\
[Nix offical documentation](https://nix.dev/)\
[Nix API search](https://noogle.dev/)\
[Nix flakes](https://wiki.nixos.org/wiki/Flakes)

### Packaging and Configuration
[Nix package search](https://search.nixos.org/packages) (Nix options search also found here)\
[Nix-darwin options search](https://daiderd.com/nix-darwin/manual/index.html)\
[Home-manager options search](https://home-manager-options.extranix.com/)
