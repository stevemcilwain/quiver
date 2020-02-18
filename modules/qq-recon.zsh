#!/usr/bin/env zsh

############################################################# 
# qq-recon
#############################################################

qq-recon-files-by-domain-metagoofil() {
  local d && read "d?DOMAIN: "
  local ft && read "ft?EXT: "
  print -z "metagoofil -u \"${__UA}\" -d ${d} -t ${ft} -o files"
}

qq-recon-wordlist-by-url-cewl() {
  local u && read "u?URL: "
  print -z "cewl -a -d 3 -m 5 -u \"${__UA}\" -w tmp.list ${u} && \
    john --wordlist=tmp.list --rules --stdout"
}

qq-recon-all-by-domain-theharvester() {
  local d && read "d?DOMAIN: "
  print -z "theharvester -d ${d} -l 50 -b all -n -t -c -e 1.1.1.1"
}

qq-recon-screens-by-url-eyewitness(){
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "eyewitness --web --user-agent \"${__UA}\" --single ${u} -d ./${d}/screens --no-dns --no-prompt "
}

qq-recon-screens-by-file-eyewitness(){
  local f=$(rlwrap -S 'FILE(URLS): ' -e '' -c -o cat)
  print -z "eyewitness --web --user-agent \"${__UA}\" -f ${f} -d ./screens --no-dns --no-prompt "
}

qq-recon-headers-curl() {
  local u && read "u?URL: "
  print -z "curl -X GET -I -L -A \"${__UA}\" ${u}"
}

