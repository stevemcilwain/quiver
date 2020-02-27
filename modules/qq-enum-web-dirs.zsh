#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-dirs
#############################################################

qq-enum-web-dirs-robots() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "curl -s -L --user-agent \"${__UA}\" ${u}/robots.txt > robots.${d}.txt"
}

qq-enum-web-dirs-robots-parsero() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "parsero -u ${u} -o -sb > robots-parsed.${d}.txt"
}

qq-enum-web-dirs-wfuzz() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "wfuzz -v -s 0.1 -R5 --hc=404 -w ${__WORDS_QUICK} ${u}FUZZ > dirs.${d}.txt "
}

qq-enum-web-files-wfuzz() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "wfuzz -v -s 0.1 --hc=404 -w ${__WORDS_NULL} ${u}/FUZZ > files.${d}.txt "
}

qq-enum-web-dirs-ffuf() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "ffuf -v -p 0.1 -t 5 -fc 404 -w ${__WORDS_QUICK} -u ${u}FUZZ "
}

qq-enum-web-files-ffuf() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "ffuf -v -p 0.1 -t 10 -fc 404 -w ${__WORDS_NULL} -u ${u}/FUZZ "
}

qq-enum-web-dirs-gobuster() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "gobuster dir -u ${u} -a \"${__UA}\" -t10 -k -w ${__WORDS_QUICK} -o dirs.${d}.txt"
}

qq-enum-web-files-gobuster() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "gobuster dir -u ${u} -a \"${__UA}\" -t10 -k  -w ${__WORDS_NULL} -o files.${d}.txt"
}

qq-enum-web-dirs-dirb-recursive() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "dirb ${u} ${__WORDS_QUICK} -a \"${__UA}\" -z 1000 -w > dirs.${d}.txt"
}

qq-enum-web-js-endpoint-finder() {
  local u && read "u?URL_JS: "
  print -z "python /opt/enum/Endpoint-Finder/EndPoint-Finder.py -u ${u}"
}