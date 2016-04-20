#!/bin/bash

os=$(uname -s | tr 'A-Z' 'a-z' | sed 's/_.*//')
case "$os" in
  linux|cygwin)
    bash_file="$HOME/.bashrc"
  ;;
  darwin)
    bash_file="$HOME/.bash_profile"
  ;;
  *)
    echo "Unrecognized operating system."
    exit 1
  ;;
esac

rm -f "$bash_file"
rm -f "$HOME/.gitconfig"
git config --global --remove-section user
rm -f "$HOME/.vim"
rm -f "$HOME/.git-prompt-colors.sh"
rm -f "$HOME/.tmux"
rm -f "$HOME/.tmux.conf"
rm -f "$HOME/.vim"
rm -f "$HOME/.vimrc"
vim +PluginClean


rm -f "$HOME/.pyenv"

rm -rf "$HOME/.dotfiles"
