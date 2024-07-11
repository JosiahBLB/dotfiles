#!/bin/sh

# add zig to path if it exists
if [ -d "$HOME/zig" ]; then
  PATH="$PATH:$HOME/zig"
fi

if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting shell to zsh"
  chsh -s "$(which zsh)"
fi
