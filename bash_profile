# Environment variables

export EDITOR=vim

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000

export TERM=xterm-256color # Needed for tmux on linux
export CLICOLOR=1

GIT_PROMPT_THEME=Custom
source "$HOME/.dotfiles/bash-git-prompt/gitprompt.sh"

unset SSH_ASKPASS

os=$(uname -s | tr 'A-Z' 'a-z' | sed 's/_.*//')
machine=$(uname -m | sed 's/i686/x86/')

case "$os" in
  linux)
    if hash setxkbmap 2>/dev/null; then
      # Remap caps lock to ctrl
      setxkbmap -option ctrl:nocaps
    fi
  ;;
  cygwin)
  ;;
  darwin)
  ;;
esac

PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
PATH=$PATH:$HOME/Developer/bin:$HOME/.dotfiles/bin
PATH=".git/safe/../../bin:$PATH"
export PATH

if [ -f /usr/local/etc/bash_completion ]; then
  source /usr/local/etc/bash_completion
fi

# Aliases and functions

alias ll='ls -l'
alias la='ll -A'
alias l='ll -h'
alias grep='grep --color'
alias nb="jupyter notebook"
alias scipy='pip install jupyter numpy scipy pandas matplotlib seaborn scikit-learn'

function calc { echo "scale=3;$@" | bc; }

g() {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    git status --short --branch
  fi
}

function ssh-copy-key {
  ssh "$1" "cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_rsa.pub
}

if [ -f ~/.bash_local ]; then
  source ~/.bash_local
fi

#export .pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
