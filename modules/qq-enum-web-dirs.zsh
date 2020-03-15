#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-dirs
#############################################################

qq-enum-web-dirs-robots() {
  __GET-URL
  print -z "curl -s -L --user-agent \"${__UA}\" ${__URL}/robots.txt"
}

qq-enum-web-dirs-robots-parsero() {
  __GET-URL
  print -z "parsero -u ${__URL} -o -sb"
}

qq-enum-web-dirs-wfuzz() {
  __GET-URL
  __GET-WORDLIST
  print -z "wfuzz -v -s 0.1 -R3 --hc=404 -w ${__WORDLIST} ${__URL}/FUZZ "
}

qq-enum-web-dirs-ffuf() {
  __GET-URL
  __GET-WORDLIST
  print -z "ffuf -v -p 0.1 -t 1 -fc 404 -w ${__WORDLIST} -u ${__URL}/FUZZ "
}

qq-enum-web-dirs-gobuster() {
  __GET-URL
  __GET-WORDLIST
  print -z "gobuster dir -u ${__URL} -a \"${__UA}\" -t1 -k -w ${__WORDLIST} -o dirs.${d}.txt"
}

qq-enum-web-dirs-dirb() {
  __GET-URL
  __GET-WORDLIST
  print -z "dirb ${__URL} ${__WORDLIST} -a \"${__UA}\" -z 1000 -w "
}

qq-enum-web-js-endpoint-finder() {
  local u && read "u?URL(JS): "
  print -z "python /opt/enum/Endpoint-Finder/EndPoint-Finder.py -u ${__URL}"
}
