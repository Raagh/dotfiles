## Dotfiles

The dotfiles for my work setup.

System: Mac OS  
Theme: tokyonight

- yabai
- skhd
- sketchybar
- alacritty
- spotlight
- zsh
- pfetch
- nvim
- finder

![nix-updated](https://user-images.githubusercontent.com/8405459/184720509-418519d0-6025-4035-9bb1-93da6ed6dc82.png)


all configurations are linked using stow

```bash
  cd dotfiles/work
  stow config -vn --adopt -t ~/.config
  stow user -vn --adopt -t ~
```
