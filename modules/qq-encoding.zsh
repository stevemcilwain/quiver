#!/usr/bin/env zsh

############################################################# 
# qq-encoding
#############################################################

qq-encoding-file-to-b64() {
  local f=$(rlwrap -S 'FILE(URLs): ' -e '' -c -o cat)
  print -z "cat ${f} | base64 > ${f}.b64"
}

qq-encoding-file-from-b64() {
  local f=$(rlwrap -S 'FILE(URLs): ' -e '' -c -o cat)
  print -z "cat ${f} | base64 -d > ${f}.txt"
}