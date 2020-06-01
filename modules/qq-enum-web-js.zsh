#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-js
#############################################################

qq-enum-web-js-help() {
    cat << "DOC"

qq-enum-web-js
--------------
The qq-enum-web-js namespace contains commands for enumerating
javascript files and mining for urls and secrets.

Commands
--------
qq-enum-web-js-install:             installs dependencies
qq-enum-web-js-beautify:            beautify JS file
qq-enum-web-js-link-finder-url:     run linkfinder on a file
qq-enum-web-js-link-finder-domain:  run linkfinder on all files of a site

DOC
}

qq-enum-web-js-install() {
    __info "Running $0..."
    __pkgs jsbeautifier qq-install-link-finder
}

qq-enum-web-js-beautify() {
    local f && __askpath f FILE $(pwd)
    print -z "js-beautify ${f} > source-${f}"
}

qq-enum-web-js-link-finder-url() {
    __check-project
    __ask "Set the URL of a javascript file"
    qq-vars-set-url
    print -z "python3 linkfinder.py -i ${__URL} -o $(__urlpath)/js-links.html"
}

qq-enum-web-js-link-finder-domain() {
    __check-project
    qq-vars-set-url
    print -z "python3 linkfinder.py -i ${__URL} -d -o $(__urlpath)/js-links-all.html"
}

