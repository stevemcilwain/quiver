#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-js
#############################################################


qq-enum-web-js-beautify() {
    local f=$(rlwrap -S "$fg[cyan]FILE(JS):$reset_color " -e '' -c -o cat)
    print -z "js-beautify ${f} > pretty-${f}"
}

qq-enum-web-js-endpoint-finder() {
    local u && read "u?$fg[cyan]URL(JS):$reset_color "
    print -z "python /opt/enum/Endpoint-Finder/EndPoint-Finder.py -u ${__URL}"
}