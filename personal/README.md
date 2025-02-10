## Dotfiles

The dotfiles for my personal setup.

System: Nix OS + Home Manager with flakes
Theme: rose-pine (applied with stylix)

- hyprland
- hyprpaper + hyprlock + hyperidle + hyprshot
- waybar
- kitty
- rofi
- zsh
- nerdfetch
- nvim

![rose-pine-hyprland-nixos](https://github.com/user-attachments/assets/f3f57a06-1a40-4d65-9535-09c2f7f0c3d7)

Initial nix configurations are linked using stow.

```bash
cd dotfiles
sudo stow personal -vn --adopt -t /etc/nixos
```
