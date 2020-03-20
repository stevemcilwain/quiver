#!/usr/bin/env zsh

############################################################# 
# qq-recon
#############################################################

qq-recon-files-by-domain-metagoofil() {
  qq-vars-set-domain
  local ft && read "ft?EXT: "
  print -z "metagoofil -u \"${__UA}\" -d ${__DOMAIN} -t ${ft} -o files"
}

qq-recon-wordlist-by-url-cewl() {
  qq-vars-set-url
  print -z "cewl -a -d 3 -m 5 -u \"${__UA}\" -w custom_list.txt ${__URL}"
}

qq-recon-all-by-domain-theharvester() {
  qq-vars-set-domain
  print -z "theHarvester -d ${__DOMAIN} -l 50 -b all"
}

qq-recon-screens-by-url-eyewitness(){
  qq-vars-set-url
  mkdir -p ./screens
  print -z "eyewitness --web --user-agent \"${__UA}\" --single ${__URL} -d ./screens --no-dns --no-prompt "
}

qq-recon-screens-by-file-eyewitness(){
  local f=$(rlwrap -S 'FILE(URLS): ' -e '' -c -o cat)
  mkdir -p ./screens
  print -z "eyewitness --web --user-agent \"${__UA}\" -f ${f} -d ./screens --no-dns --no-prompt "
}

qq-recon-headers-curl() {
  qq-vars-set-url
  print -z "curl -X GET -I -L -A \"${__UA}\" ${__URL}"
}

