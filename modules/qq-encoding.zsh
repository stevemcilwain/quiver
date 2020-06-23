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
qq-encoding-file-to-b64:       encodes plain text file to base64, optional $1 as file
qq-encoding-file-from-b64:     decodes base64 file to plain text, optional $1 as file

DOC
}

qq-encoding-file-to-b64() {
    if [ "$#" -eq  "1" ]
    then
        print -z "cat $1 | base64 > $1.b64"
    else 
        local f && __askpath f FILE $(pwd)
        print -z "cat ${f} | base64 > ${f}.b64"
    fi
}

qq-encoding-file-from-b64() {
    if [ "$#" -eq  "1" ]
    then
        print -z "cat $1 | base64 -d > $1.txt"
    else 
        local f && __askpath f FILE $(pwd)
        print -z "cat ${f} | base64 -d > ${f}.txt"
    fi
}