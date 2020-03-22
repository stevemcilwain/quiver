#!/usr/bin/env zsh

############################################################# 
# qq-scripts
#############################################################

qq-scripts-webrecon() {
  local f=$(rlwrap -S "$fg[cyan]FILE(DOMAINS):$reset_color " -e '' -c -o cat)
  __warn "Using output: $(pwd)"
  print -z "zsh ${__SCRIPTS}/webrecon.zsh ${f}"
}

qq-scripts-recon() {
  local d && read "d?$fg[cyan]DOMAIN:$reset_color "
  local o && read "o?$fg[cyan]ORG:$reset_color "
  __warn "Using output: $(pwd)"
  print -z "zsh ${__SCRIPTS}/recon.zsh ${d} \"${o}\""
}

