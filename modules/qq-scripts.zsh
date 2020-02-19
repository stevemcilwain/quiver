#!/usr/bin/env zsh

############################################################# 
# qq-scripts
#############################################################

qq-scripts-webrecon() {
  local f=$(rlwrap -S 'FILE(DOMAINS): ' -e '' -c -o cat)
  __warn "Using output: $(pwd)"
  print -z "zsh ${__SCRIPTS}/webrecon.sh ${f}"
}

