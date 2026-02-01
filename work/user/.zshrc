export ZSH="//$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

export PATH=$PATH:/usr/local/go/bin

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export BAT_THEME="ansi"
export NVM_DIR="$HOME/.nvm"

autoload -U promptinit; promptinit
autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats "%b"

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" ✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"
ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'


setopt prompt_subst
PROMPT="%F{011}%~ %F{060}%n@%m%F{010}"$'\n'" ❯ %f"

RPROMPT='%F{060}${vcs_info_msg_0_}`git_prompt_status`'

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
HIST_STAMPS="dd/mm/yyyy"
compinit
_comp_options+=(globdots) # lets you tab complete hidden files by default

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -f ~/.zshrc-personal ]] && . ~/.zshrc-personal
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
# Auto-start tmux (like zellij enableZshIntegration)
if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && [[ -z "$SSH_CONNECTION" ]]; then
  # Try to attach to main session first, then any other session except popup
  if tmux has-session -t "main" 2>/dev/null; then
    exec tmux attach -t "main"
  elif tmux has-session 2>/dev/null; then
    # Attach to first session that's not the popup session
    MAIN_SESSION=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | grep -v "popup" | head -1)
    if [[ -n "$MAIN_SESSION" ]]; then
      exec tmux attach -t "$MAIN_SESSION"
    else
      exec tmux new-session -s "main"
    fi
  else
    exec tmux new-session -s "main"
  fi
fi

export DOTNET_ROOT="/usr/local/share/dotnet"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/pferraggi/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
