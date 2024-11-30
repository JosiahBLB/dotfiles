# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#===============================================================================  
#  ohmyzsh Configuration
#------------------------------------------------------------------------------- 

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.config/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# hyphen-insensitive completion.
HYPHEN_INSENSITIVE="true"

# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking

# how often to auto-update (in days).
zstyle ':omz:update' frequency 30

# Ignore EOF to prevent Ctrl-D from closing the terminal
setopt IGNOREEOF

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$ZSH"/custom


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    fzf-tab
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

#===============================================================================  
# Default config
#------------------------------------------------------------------------------- 

typeset -U path cdpath fpath manpath

# Use modern completion system
autoload -Uz compinit; compinit

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# tmux dialog box
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

#===============================================================================  
# Custom config
#------------------------------------------------------------------------------- 

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.config/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

# save history from multiple tmux sessions in the same hist file
export PROMPT_COMMAND='history -a;history -r'
setopt histignorealldups sharehistory

# ctrl + space to accept zsh suggestions
bindkey '^ ' autosuggest-accept

# hard coding what should be default
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# set directory for dotfiles
source "$ZDOTDIR"/.zsh_aliases

# To customize prompt, run `p10k configure` or edit ~/.config/.p10k.zsh.
[[ ! -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh
