#!/usr/bin/env zsh

############################################################# 
# qq-util
#############################################################

qq-util-update-quiver() {
  cd ~/.oh-my-zsh/custom/plugins/quiver
  git pull
  cd -
  source ~/.zshrc
}

alias qq-util-source-zshrc="source ~/.zshrc"

alias qq-util-to-csv="paste -s -d, -"

qq-util-get-ip() {
  curl icanhazip.com
}

qq-util-sort-file() {
  cat $1 | sort -u -o $1
}