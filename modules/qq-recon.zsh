#!/usr/bin/env zsh

############################################################# 
# qq-recon
#############################################################

qq-recon-files-by-domain-metagoofil() {
  __GET-DOMAIN
  local ft && read "ft?EXT: "
  print -z "metagoofil -u \"${__UA}\" -d ${__DOMAIN} -t ${ft} -o files"
}

qq-recon-wordlist-by-url-cewl() {
  __GET-URL
  print -z "cewl -a -d 3 -m 5 -u \"${__UA}\" -w custom_list.txt ${__URL}"
}

qq-recon-all-by-domain-theharvester() {
  __GET-DOMAIN
  print -z "theHarvester -d ${__DOMAIN} -l 50 -b all"
}

qq-recon-screens-by-url-eyewitness(){
  __GET-URL
  mkdir -p ./screens
  print -z "eyewitness --web --user-agent \"${__UA}\" --single ${__URL} -d ./screens --no-dns --no-prompt "
}

qq-recon-screens-by-file-eyewitness(){
  local f=$(rlwrap -S 'FILE(URLS): ' -e '' -c -o cat)
  mkdir -p ./screens
  print -z "eyewitness --web --user-agent \"${__UA}\" -f ${f} -d ./screens --no-dns --no-prompt "
}

qq-recon-headers-curl() {
  __GET-URL
  print -z "curl -X GET -I -L -A \"${__UA}\" ${__URL}"
}

