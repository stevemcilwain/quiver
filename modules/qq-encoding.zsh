#!/usr/bin/env zsh

############################################################# 
# qq-encoding
#############################################################

qq-encoding-help() {
  cat << "DOC"

qq-encoding
----------
The encoding namespace provides commands for encoding and decoding values.

Commands
--------
qq-encoding-file-to-b64:       encodes plain text file to base64
qq-encoding-file-from-b64:     decodes base64 file to plain text

DOC
}

qq-encoding-file-to-b64() {
  local f && __askpath f FILE $(pwd)
  print -z "cat ${f} | base64 > ${f}.b64"
}

qq-encoding-file-from-b64() {
  local f && __askpath f FILE $(pwd)
  print -z "cat ${f} | base64 -d > ${f}.txt"
}