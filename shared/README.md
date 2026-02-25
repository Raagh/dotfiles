## This contains the things I share across installs

- Corne
- Neovim
- OpenCode

My Corne configuration is Vial based so I only keep the json here.
Neovim and OpenCode are stowed to the config directory.

```bash
  cd dotfiles/shared
  stow nvim -vn --adopt -t ~/.config
  stow opencode -vn --adopt -t ~/.config
```
