# Yazi config

File manager config focused on previews.

## Files

| File | Purpose |
| --- | --- |
| `.config/yazi/yazi.toml` | Main Yazi config, open rules, previewers, and task settings |

## Preview dependencies

Install these on Arch for image and PDF previews:

```sh
sudo pacman -S --needed ueberzugpp chafa poppler imagemagick
```

`poppler` provides `pdftoppm`; ImageMagick provides `magick`.

## Install

From the repo root:

```sh
stow --target="$HOME" yazi
```
