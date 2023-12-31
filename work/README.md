## Dotfiles

The dotfiles for my work setup.

System: Ubuntu 22.04.3 LTS
Theme: tokyonight

- i3 + gnome-flashback
- alacritty
- rofi
- zsh
- pfetch
- nvim
- gnome apps


![screenshot](https://github.com/Raagh/dotfiles/assets/8405459/5a35b92b-e190-45fd-b8b9-5283c99878e7)


all configurations are linked using stow

```bash
  cd dotfiles/work
  stow config -vn --adopt -t ~/.config
  stow user -vn --adopt -t ~
  cd dotfiles/shared
  stow nvim -vn --adopt -t ~/.config
```
