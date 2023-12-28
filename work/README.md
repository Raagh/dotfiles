## Dotfiles

The dotfiles for my work setup.

System: Ubuntu 22.04.3 LTS
Theme: tokyonight

- i3
- alacritty
- dmenu
- zsh
- neofetch
- nvim
- Thunar

<img width="1728" alt="Screenshot 2023-04-02 at 13 09 13" src="https://user-images.githubusercontent.com/8405459/229350237-19f41c4c-e6c5-42f0-b9c5-9e1b23350ff7.png">

all configurations are linked using stow

```bash
  cd dotfiles/work
  stow config -vn --adopt -t ~/.config
  stow user -vn --adopt -t ~
  cd dotfiles/shared
  stow nvim -vn --adopt -t ~/.config
```
