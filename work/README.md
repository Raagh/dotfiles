## Dotfiles

The dotfiles for my work setup.

System: Mac OS

Theme: kanagawa

- homebrew
- aerospace
- kitty
- alfred
- zsh
- pfetch
- nvim

![image](https://github.com/user-attachments/assets/e73acadf-0112-490d-a4de-058225776877)

all configurations are linked using stow

```bash
  cd dotfiles/work
  stow config -vn --adopt -t ~/.config
  stow user -vn --adopt -t ~
  cd dotfiles/shared
  stow nvim -vn --adopt -t ~/.config
```
