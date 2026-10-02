# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybinds
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-clear
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ll='ls -l --color'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rune='flatpak run com.jagex.Launcher'

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git --exclude node_modules --exclude target --exclude gdrive . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --hidden --type d --exclude .git --exclude node_modules --exclude target --exclude gdrive . $HOME"
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target,gdrive
  --height 80%
  --preview 'if test -d {}; then ls -la --color=always -- {}; else bat -n --color=always -- {}; fi'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

__fzf_gdrive_select() {
  fd --hidden --follow "$@" . "$HOME/gdrive" | fzf \
    --height 80% \
    --scheme=path \
    --preview 'if test -d {}; then ls -la --color=always -- {}; else bat -n --color=always -- {}; fi' \
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
}

fgdrive() {
  __fzf_gdrive_select
}

cdgdrive() {
  local dir
  dir="$(__fzf_gdrive_select --type d)" || return
  [[ -n "$dir" ]] && builtin cd -- "$dir"
}

__fzf_gdrive_widget() {
  local dir
  dir="$(__fzf_gdrive_select --type d)" || return
  [[ -n "$dir" ]] && builtin cd -- "$dir"
  zle reset-prompt
}
zle -N fzf-gdrive-widget __fzf_gdrive_widget
bindkey '^[g' fzf-gdrive-widget

# Shell integrations
eval "$(fzf --zsh)"

# Yazi

export EDITOR="nvim"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
eval "$(pyenv init - --no-rehash)"

setxkbmap -option ctrl:swapcaps

neofetch
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/mark/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# Tuxedo todo.txt
export TODO_DIR="$HOME/tasks"
export TODO_FILE="$TODO_DIR/todo.txt"
export DONE_FILE="$TODO_DIR/done.txt"

# opencode
export PATH=/home/mark/.opencode/bin:$PATH
