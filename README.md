## Manual Configuration
### Iterm2
- Importing colors using `Profiles > Colors > Color > Color Presets... > Import...` 
- Setting compatible terminal keymappings using `Profiles > Keys > Key Mappings > Presets... > Natural Text Editing`
- Un-setting `Apps can change how keys are reported` in `Profiles > Keys > General`
- Setting `Left Option key` to `Esc+` in `Profiles > Keys > General` [source](https://github.com/helix-editor/helix/issues/2280#issuecomment-1165542932)
- Setting `Applications in terminal may access clipboard` in `General > Selection` [source](https://github.com/helix-editor/helix/issues/8715)
- Setting font to `JetBrainsMono Nerd Font Mono` with font size 14

## Issues
- I accidentally reset (`⌘-R`) iterm2 and lost the ability to run binaries. This was fixed by temporarily adding the following to \$PATH `export PATH="$PATH:/run/current-system/sw/bin"` and then running `darwin-rebuild switch --flake .` again
