#!/bin/sh

# Allows for easy generation of clang-format files
clang_format_gen() {
  if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then # help menu
    echo "Usage: clang_format_gen <style>\ni.e cland_format_gen <style>\nThe following choices are:\nLLVM, Google, Chromium, Mozilla, Webkit, Microsoft and GNU"
  elif [ -n "$1" ]; then # choose one from the list
    clang-format --style="{BasedOnStyle: $1, IndentWidth: 4}" --dump-config > .clang-format
  else # default to llvm
    clang-format --style="{BasedOnStyle: llvm, IndentWidth: 4}" --dump-config > .clang-format
  fi
}
