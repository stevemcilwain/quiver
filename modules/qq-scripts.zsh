#!/usr/bin/env zsh

############################################################# 
# qq-scripts
#############################################################

# qq-scripts-help() {
#   cat << "DOC"

# qq-scripts
# -------
# The scripts namespace runs scripts from the quiver
# scripts directory.

# ** IN DEVELOPMENT, NOT READY FOR USE **

# Commands
# --------
# qq-scripts-recon: a zsh recon script
# qq-scripts-webrecon: a zsh webrecon script

# DOC
# }

# qq-scripts-recon() {
#   local d && read "d?$(__cyan DOMAIN: )"
#   local o && read "o?$(__cyan ORG: )"
#   local w && read "out?$(__cyan WORKING\(DIR\): )"
#   print -z "zsh ${__SCRIPTS}/recon.zsh ${d} \"${o}\" \"${w}\""
# }

# qq-scripts-webrecon() {
#   local f=$(rlwrap -S "$(__cyan FILE:\(DOMAINS\))" -e '' -c -o cat)
#   local w && read "out?$(__cyan WORKING\(DIR\): )"
#   pushd ${w}
#   print -z "zsh ${__SCRIPTS}/webrecon.zsh ${f}"
#   popd
# }


