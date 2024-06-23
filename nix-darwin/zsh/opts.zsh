#!/bin/sh

# save history from multiple tmux sessions in the same hist file
export PROMPT_COMMAND='history -a;history -r'

# source powerlevel10k theme
test -f ~/.config/.p10k.zsh && source ~/.config/.p10k.zsh

# ctrl + space to accept zsh suggestions
bindkey '^ ' autosuggest-accept

# hard coding what should be default
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
