#!/bin/bash

os=$(uname -s | tr 'A-Z' 'a-z' | sed 's/_.*//')
case "$os" in
  linux|cygwin)
    #assuming ubuntu/debian distros
    sudo apt-get update; 
    # install required programs
    sudo apt-get install vim tmux git openssh-server nmap python-virtualenv
    # Requisites for pyenv
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev

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
ln -sf "$HOME/.dotfiles/bash_profile" "$bash_file"

# GIT configuration
keep_git_user="$1"
if [[ -z "$keep_git_user" ]]
then
  read -p "Keep git user settings for Gautam (y/n)? "
  keep_git_user="$REPLY"
fi
ln -sf "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig"
if [[ "$keep_git_user" != "y" ]]
then
  git config --global --remove-section user
fi
ln -snf "$HOME/.dotfiles/git-prompt-colors.sh" "$HOME/.git-prompt-colors.sh"

# TMUX configuration
ln -snf "$HOME/.dotfiles/tmux" "$HOME/.tmux"
ln -snf "$HOME/.tmux/tmux.conf" "$HOME/.tmux.conf"

# VIM editor configuration
if [[ -e "$HOME/.vim" ]]
then
  rm -rf "$HOME/.vim"
fi
ln -snf "$HOME/.dotfiles/vim" "$HOME/.vim"
ln -sf "$HOME/.vim/vimrc" "$HOME/.vimrc"
vim +PluginInstall +qall


ln -snf "$HOME/.dotfiles/pyenv" "$HOME/.pyenv"
