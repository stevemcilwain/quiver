#!/usr/bin/env zsh

############################################################# 
# qq-util
#############################################################

alias qq-util-to-csv="paste -s -d, -"

qq-util-get-ip() {
  curl icanhazip.com
}

qq-util-sort-file() {
  cat $1 | sort -u -o $1
}