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
- pfetch
- nvim

![rose-pine-hyprland-nixos](https://github.com/user-attachments/assets/f3f57a06-1a40-4d65-9535-09c2f7f0c3d7)

Initial nix configurations are linked using stow.

This configuration expects you that you first install the default gnome NixOS image and then install this:

I don't keep anything from gnome but I use some of the folders gnome creates like Downloads, Pictures, etc
It is also very helpful to have gnome generation working at the beginning in case we break something during the setup
You can then go back to a functioning Desktop Environment

```bash
cd dotfiles
sudo stow personal -vn --adopt -t /etc/nixos
```

After the setup you should enable zellij "unlock first" [keybinding preset](https://zellij.dev/documentation/keybinding-presets.html?highlight=set%20preset#keybinding-presets) as there is currently no way to configure this
