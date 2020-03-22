#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-dirs
#############################################################

qq-enum-web-dirs-robots() {
  qq-vars-set-url
  print -z "curl -s -L --user-agent \"${__UA}\" ${__URL}/robots.txt > $(__urlpath)/robots.txt"
}

qq-enum-web-dirs-parsero-robots() {
  qq-vars-set-url
  print -z "parsero -u ${__URL} -o -sb > $(__urlpath)/robots.txt"
}

qq-enum-web-dirs-wfuzz() {
  qq-vars-set-url
  qq-vars-set-wordlist
  print -z "wfuzz -v -s 0.1 -R3 --hc=404 -w ${__WORDLIST} ${__URL}/FUZZ --oF $(__urlpath)/wfuzz-dirs.txt"
}

qq-enum-web-dirs-ffuf() {
  qq-vars-set-url
  qq-vars-set-wordlist
  print -z "ffuf -v -p 0.1 -t 1 -fc 404 -w ${__WORDLIST} -u ${__URL}/FUZZ "
}

qq-enum-web-dirs-gobuster() {
  qq-vars-set-url
  qq-vars-set-wordlist
  print -z "gobuster dir -u ${__URL} -a \"${__UA}\" -t1 -k -w ${__WORDLIST} > $(__urlpath)/gobuster-dirs.txt "
}

qq-enum-web-js-endpoint-finder() {
  local u && read "u?$fg[cyan]URL(JS):$reset_color "
  print -z "python /opt/enum/Endpoint-Finder/EndPoint-Finder.py -u ${__URL}"
}
