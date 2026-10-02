# macOS interactive Zsh configuration.
# Managed in the dotfiles repository and linked to ~/.zshrc.

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ -r "$ZINIT_HOME/zinit.zsh" ]]; then
    source "$ZINIT_HOME/zinit.zsh"
    zinit ice depth=1
    zinit light romkatv/powerlevel10k
    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-autosuggestions
fi

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
if (( $+functions[_zsh_autosuggest_start] )); then
    bindkey '^ ' autosuggest-accept
    bindkey '^f' autosuggest-clear
fi

# Aliases (macOS's built-in ls uses -G for color)
alias ls='ls -G'
alias ll='ls -lG'

# Editor
if (( $+commands[nvim] )); then
    export EDITOR="nvim"
fi

# Load syntax highlighting after other widgets and keybindings.
if (( $+functions[zinit] )); then
    zinit light zsh-users/zsh-syntax-highlighting
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
