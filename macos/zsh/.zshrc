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

# fzf
if (( $+commands[fzf] )); then
    if (( $+commands[fd] )); then
        export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git --exclude node_modules --exclude target --exclude gdrive ."
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --hidden --type d --exclude .git --exclude node_modules --exclude target --exclude gdrive ."
    fi

    export FZF_CTRL_T_OPTS="--height 80% --bind 'ctrl-/:change-preview-window(down|hidden|)'"
    if (( $+commands[bat] )); then
        export FZF_CTRL_T_OPTS="$FZF_CTRL_T_OPTS
            --preview 'if test -d {}; then CLICOLOR_FORCE=1 /bin/ls -lahG -- {}; else bat --style=numbers --color=always --paging=never -- {}; fi'"
    fi

    eval "$(fzf --zsh)"
fi

# Yazi: return to the selected directory when quitting with q.
if (( $+commands[yazi] )); then
    function y() {
        local tmp cwd exit_code
        tmp="$(mktemp -t "yazi-cwd.XXXXXX")" || return
        command yazi "$@" --cwd-file="$tmp"
        exit_code=$?
        IFS= read -r -d '' cwd < "$tmp"
        if (( exit_code == 0 )) && [[ -d "$cwd" && "$cwd" != "$PWD" ]]; then
            builtin cd -- "$cwd"
        fi
        command rm -f -- "$tmp"
        return "$exit_code"
    }
fi

# Load syntax highlighting after other widgets and keybindings.
if (( $+functions[zinit] )); then
    zinit light zsh-users/zsh-syntax-highlighting
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
