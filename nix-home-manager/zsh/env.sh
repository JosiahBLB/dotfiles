# add zig to path if it exists
if [ -d "$HOME/zig" ]; then
  PATH="$PATH:$HOME/zig"
fi

export PATH="$PATH:/Users/josiah/Library/Python/3.9/bin"

# change ruby version
source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
if ! chruby | rg -q ruby-3.3.5; then
  ruby-install ruby 3.3.5
fi
chruby ruby-3.3.5

# nvm
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
fi
