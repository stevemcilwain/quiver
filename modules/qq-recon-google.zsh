#!/usr/bin/env zsh

############################################################# 
# Recon - Google Dorks
#############################################################

# TODO: implement token based search and replace for site:

subs() {
    local search=$1
    local replace=$2
    sed -i "" "s/${search}/${replace}/g" dorks-google.txt
}

