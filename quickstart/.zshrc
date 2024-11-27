typeset -U path cdpath fpath manpath

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

# add zig to path if it exists
if [ -d "$HOME/zig" ]; then
  PATH="$PATH:$HOME/zig"
fi

# save history from multiple tmux sessions in the same hist file
export PROMPT_COMMAND='history -a;history -r'

# ctrl + space to accept zsh suggestions
bindkey '^ ' autosuggest-accept

# hard coding what should be default
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

alias ls="lsd"
alias la="lsd -lA --no-symlink --date '+%Y-%m-%d %X'"
alias lt="lsd --tree"
alias ldir="lsd -Ad --tree"
alias lat="lsd -A --tree"
alias lsg="git ls-files --others --exclude-standard --cached --directory | grep -v '/' | xargs lsd"

# Aliases
alias -- vimdiff='nvim -d'
