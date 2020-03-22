#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-fuzz
#############################################################

qq-enum-web-fuzz-auth-basic-payloads() {
  qq-vars-set-wordlist
  local u && read "u?$fg[cyan]USERNAME:$reset_color "
  print -z "file=\"${f}\"; while IFS= read line; do; echo -n \"${u}:\$line\" | base64 ; done <\"\$file\" > payloads.b64"
}

# ffuf

qq-enum-web-fuzz-auth-basic-ffuf() {
  qq-vars-set-url
  local f=$(rlwrap -S "$fg[cyan]FILE(payloads):$reset_color " -e '' -c -o cat)
  print -z "ffuf -t 1 -p \"0.1\" -w ${f} -H \"Authorization: Basic FUZZ\" -fc 401 -u ${__URL}  "
}

qq-enum-web-fuzz-post-json-ffuf() {
  qq-vars-set-url
  print -z "ffuf -t 1 -p \"0.1\" -w /usr/share/seclists/Fuzzing/Databases/NoSQL.txt -u ${__URL} -X POST -H \"Content-Type: application/json\" -d '{\"username\": \"FUZZ\", \"password\": \"FUZZ\"}' -fr \"error\" "
}

qq-enum-web-fuzz-auth-post-ffuf() {
  qq-vars-set-url
  local uf && read "u?$fg[cyan]USERNAME(field):$reset_color "
  local uv && read "user?$fg[cyan]USER(value):$reset_color "
  local pf && read "p?$fg[cyan]PASSWORD(field):$reset_color "
  print -z "ffuf -t 1 -p \"0.1\" -w ${__PASSLIST}  -H \"Content-Type: application/x-www-form-urlencoded\" -X POST -d \"${uf}=${uv}&${pf}=FUZZ\" -u ${__URL} -fs 75 "
}

# wfuzz

qq-enum-web-fuzz-auth-post-wfuzz() {
  qq-vars-set-url
  local uf && read "u?$fg[cyan]USERNAME(field):$reset_color "
  local uv && read "user?$fg[cyan]USER(value):$reset_color "
  local pf && read "p?$fg[cyan]PASSWORD(field):$reset_color "
  print -z "wfuzz -c -w ${__PASSLIST} -d \"${uf}=${uv}&${pf}=FUZZ\" --sc 302 ${__URL}"
}

qq-enum-web-brute-hydra-get() {
  qq-vars-set-rhost
  local user && read "user?$fg[cyan]USERNAME:$reset_color "
  local path && read "path?$fg[cyan]PATH(/path):$reset_color "
  print -z "hydra -l ${user} -P ${__PASSLIST} ${__RHOST} http-get ${path}"
}

qq-enum-web-brute-hydra-form-post() {
  qq-vars-set-rhost
  local path && read "path?$fg[cyan]PATH:$reset_color "
  local u && read "u?$fg[cyan]USERNAME(field):$reset_color "
  local user && read "user?$fg[cyan]USER(value):$reset_color "
  local p && read "p?$fg[cyan]PASSWORD(field):$reset_color "
  local fm && read"fm?$fg[cyan]FAILED(message):$reset_color "
  print -z "hydra ${__RHOST} http-form-post \"${path}:${u}=^USER^&${p}=^PASS^:${fm}\" -l $u -P ${__PASSLIST} -t 10 -w 30 "
}