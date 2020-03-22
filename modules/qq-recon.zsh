#!/usr/bin/env zsh

############################################################# 
# qq-recon
#############################################################

qq-recon-files-by-domain-metagoofil() {
  qq-vars-set-domain
  local ft && read "ft?$fg[cyan]EXT:$reset_color "
  print -z "metagoofil -u \"${__UA}\" -d ${__DOMAIN} -t ${ft} -o ${__OUTPUT}/files"
}

qq-recon-wordlist-by-url-cewl() {
  qq-vars-set-url
  print -z "cewl -a -d 3 -m 5 -u \"${__UA}\" -w ${__OUTPUT}/recon/custom_list.txt ${__URL}"
}

qq-recon-all-by-domain-theharvester() {
  qq-vars-set-domain
  print -z "theHarvester -d ${__DOMAIN} -l 50 -b all -f ${__OUTPUT}/recon/harvester.txt"
}

qq-recon-screens-by-url-eyewitness(){
  qq-vars-set-url
  mkdir -p $(__urlpath)/screens
  print -z "eyewitness --web --user-agent \"${__UA}\" --single ${__URL} -d $(__urlpath)/screens --no-dns --no-prompt "
}

qq-recon-screens-by-file-eyewitness(){
  local f=$(rlwrap -S "$fg[cyan]FILE(URLS):$reset_color " -e '' -c -o cat)
  mkdir -p $(__urlpath)/screens
  print -z "eyewitness --web --user-agent \"${__UA}\" -f ${f} -d $(__urlpath)/screens --no-dns --no-prompt "
}

qq-recon-headers-curl() {
  qq-vars-set-url
  print -z "curl -X GET -I -L -A \"${__UA}\" ${__URL}"
}

