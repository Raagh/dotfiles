## Dotfiles

The dotfiles for my current setup.

Nix OS (for now) - tokyonight

- bspwm
- polybar
- alacritty
- nitrogen
- rofi
- picom
- dunst
- zsh
- neofetch
- nvim
- ranger
- zathura

![nix-updated](https://user-images.githubusercontent.com/8405459/184720509-418519d0-6025-4035-9bb1-93da6ed6dc82.png)


all configurations are linked using stow

```bash
  cd dotfiles
  stow config -vn --adopt -t ~/.config
  sudo stow nix -vn --adopt -t /etc/nixos
  stow user -vn --adopt -t ~
```
