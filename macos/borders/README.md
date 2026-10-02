# macOS window borders

JankyBorders with rounded, 3-point borders: Catppuccin Mocha lavender for the
focused window and Surface 1 gray for inactive windows.

Install and link from the repository root:

```sh
brew install FelixKratz/formulae/borders
stow --dir=macos --target="$HOME" borders aerospace
```

AeroSpace starts borders on launch. To start borders manually, run `borders`.
After editing `~/.config/borders/bordersrc`, run that script to apply changes:

```sh
~/.config/borders/bordersrc
```
