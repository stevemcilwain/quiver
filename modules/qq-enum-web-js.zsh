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
qq-enum-web-js-curl:                enumerate links using curl

DOC
}

qq-enum-web-js-install() {
    __info "Running $0..."
    __pkgs jsbeautifier qq-install-link-finder
}

qq-enum-web-js-beautify() {
    local f && __askpath f FILE $(pwd)
    print -z "js-beautify ${f} > source-$(basename ${f})"
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

qq-enum-web-js-curl() {
    qq-vars-set-url
    curl -Lks ${__URL} | tac | sed "s#\\\/#\/#g" | egrep -o "src['\"]?\s*[=:]\s*['\"]?[^'\"]+.js[^'\"> ]*" | sed -r "s/^src['\"]?[=:]['\"]//g" | awk -v url=${__URL} '{if(length($1)) if($1 ~/^http/) print $1; else if($1 ~/^\/\//) print "https:"$1; else print url"/"$1}' | sort -fu | xargs -I '%' sh -c "echo \"'##### %\";curl -k -s \"%\" | sed \"s/[;}\)>]/\n/g\" | grep -Po \"('#####.*)|(['\\\"](https?:)?[/]{1,2}[^'\\\"> ]{5,})|(\.(get|post|ajax|load)\s*\(\s*['\\\"](https?:)?[/]{1,2}[^'\\\"> ]{5,})\" | sort -fu" | tr -d "'\""
}


