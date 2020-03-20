#!/usr/bin/env zsh

############################################################# 
# qq-scripts
#############################################################

qq-scripts-webrecon() {
  local f=$(rlwrap -S "FILE(DOMAINS): " -e '' -c -o cat)
  __warn "Using output: $(pwd)"
  print -z "zsh ${__SCRIPTS}/webrecon.zsh ${f}"
}

qq-scripts-recon() {
  local d && read "d?DOMAIN: "
  local o && read "o?ORG: "
  __warn "Using output: $(pwd)"
  print -z "zsh ${__SCRIPTS}/recon.zsh ${d} \"${o}\""
}

