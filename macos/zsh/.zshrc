# macOS interactive Zsh configuration.
# Managed in the dotfiles repository and linked to ~/.zshrc.

# History
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Keybinds
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Aliases (macOS's built-in ls uses -G for color)
alias ls='ls -G'
alias ll='ls -lG'

# Editor
if (( $+commands[nvim] )); then
    export EDITOR="nvim"
fi
