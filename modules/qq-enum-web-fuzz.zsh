#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-fuzz
#############################################################

qq-enum-web-fuzz-help() {
    cat << "DOC"

qq-enum-web-fuzz
--------------
The qq-enum-web-fuzz namespace contains commands for fuzzing
inputs of web applications

Commands
--------
qq-enum-web-fuzz-install:                  installs dependencies
qq-enum-web-fuzz-auth-basic-payloads:      generate base64 encoded credentials
qq-enum-web-fuzz-auth-basic-ffuf:          brute force basic auth
qq-enum-web-fuzz-auth-json-ffuf:           brute force basic auth with json post
qq-enum-web-fuzz-auth-post-ffuf:           brute force auth with post
qq-enum-web-fuzz-auth-post-wfuzz:          brute force auth with post
qq-enum-web-brute-hydra-get:               brute force auth with get
qq-enum-web-brute-hydra-form-post:         brute force auth with post

DOC
}

qq-enum-web-fuzz-install() {
    __info "Running $0..."
    __pkgs seclists wordlists wfuzz hydra
    qq-install-golang
    go get -u github.com/ffuf/ffuf
}


qq-enum-web-fuzz-auth-basic-payloads() {
    qq-vars-set-wordlist
    __check-user
    print -z "file=\"${f}\"; while IFS= read line; do; echo -n \"${__USER}:\$line\" | base64 ; done <\"\$file\" > payloads.b64"
}

# ffuf

qq-enum-web-fuzz-auth-basic-ffuf() {
    qq-vars-set-url
    __ask "Select file containing authorization header payloads"
    local f && __askpath f FILE $(pwd)
    __check-threads
    print -z "ffuf -t ${__THREADS} -p \"0.1\" -w ${f} -H \"Authorization: Basic FUZZ\" -fc 401 -u ${__URL}  "
}

qq-enum-web-fuzz-auth-json-ffuf() {
    qq-vars-set-url
    __check-threads
    print -z "ffuf -t ${__THREADS} -p \"0.1\" -w /usr/share/seclists/Fuzzing/Databases/NoSQL.txt -u ${__URL} -X POST -H \"Content-Type: application/json\" -d '{\"username\": \"FUZZ\", \"password\": \"FUZZ\"}' -fr \"error\" "
}

qq-enum-web-fuzz-auth-post-ffuf() {
    qq-vars-set-url
    local uf && __askvar uf USER_FIELD
    local uv && __askvar uv USER_VALUE
    local pf && __askvar pf PASSWORD_FIELD
    __check-threads
    print -z "ffuf -t ${__THREADS}  -p \"0.1\" -w ${__PASSLIST}  -H \"Content-Type: application/x-www-form-urlencoded\" -X POST -d \"${uf}=${uv}&${pf}=FUZZ\" -u ${__URL} -fs 75 "
}

# wfuzz

qq-enum-web-fuzz-auth-post-wfuzz() {
    qq-vars-set-url
    local uf && __askvar uf USER_FIELD
    local uv && __askvar uv USER_VALUE
    local pf && __askvar pf PASSWORD_FIELD
    print -z "wfuzz -c -w ${__PASSLIST} -d \"${uf}=${uv}&${pf}=FUZZ\" --sc 302 ${__URL}"
}

qq-enum-web-brute-hydra-get() {
    qq-vars-set-rhost
    __check-user
    __ask "Enter the URI for the get request, ex: /path"
    local uri && __askvar uri URI
    print -z "hydra -l ${__USER} -P ${__PASSLIST} ${__RHOST} http-get ${uri}"
}

qq-enum-web-brute-hydra-form-post() {
    qq-vars-set-rhost
    __ask "Enter the URI for the post request, ex: /path"
    local uri && __askvar uri URI
    local uf && __askvar uf USER_FIELD
    local uv && __askvar uv USER_VALUE
    local pf && __askvar pf PASSWORD_FIELD
    __ask "Enter the response value to check for failure"
    local fm && __askvar fm FAILURE
    print -z "hydra ${__RHOST} http-form-post \"${uri}:${uf}=^USER^&${pf}=^PASS^:${fm}\" -l ${uv} -P ${__PASSLIST} -t 10 -w 30 "
}