## Dotfiles

The dotfiles for my personal setup.

System: Nix OS
Theme: rose-pine

- hyprland
- waybar
- kitty
- hyprpaper
- wofi
- zsh
- nerdfetch
- nvim

![rose-pine-readme](https://user-images.githubusercontent.com/8405459/214701411-b2728d3a-8144-41e8-8edc-b66f9a6ca7d7.png)

all configurations are linked using stow

```bash
cd dotfiles
sudo stow personal -vn --adopt -t /etc/nixos
```
