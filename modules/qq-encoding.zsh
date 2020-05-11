#!/usr/bin/env zsh

############################################################# 
# qq-encoding
#############################################################

qq-encoding-help() {
  cat << END

qq-encoding
----------
The encoding namespace provides commands for encoding and decoding values.

Commands
--------
qq-encoding-file-to-b64: encodes plain text file to base64
qq-encoding-file-from-b64: decodes base64 file to plain text

END
}

qq-encoding-file-to-b64() {
  local f=$(rlwrap -S "$(__cyan FILE\(plain\): )" -e '' -c -o cat)
  print -z "cat ${f} | base64 > ${f}.b64"
}

qq-encoding-file-from-b64() {
  local f=$(rlwrap -S "$(__cyan FILE\(b64\): )" -e '' -c -o cat)
  print -z "cat ${f} | base64 -d > ${f}.txt"
}