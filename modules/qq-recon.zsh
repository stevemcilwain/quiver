#!/usr/bin/env zsh

############################################################# 
# qq-recon
#############################################################

qq-recon-script-webrecon() {
  local f=$(rlwrap -S 'Select domains file: ' -e '' -c -o cat)
  [[ ! -f $f ]] && err "${f} does not exist" && return
  __info "Using ${f} as input" 
  __warn "Using $(pwd) as output directory"
  print -z "${__SCRIPTS}/webrecon.sh ${f}"
}

qq-recon-files-metagoofil() {
  local d && read "d?Domain: "
  local ft && read "ft?File type: "
  print -z "metagoofil -d ${d} -t ${ft} -o files"
}

qq-recon-wordlist-by-website-cewl() {
  __check-UA
  local u && read "u?Url: "
  print -z "cewl -a -d 3 -m 5 -u \"${__UA}\" -w tmp.list ${u} && \
    john --wordlist=tmp.list --rules --stdout"
}

qq-recon-all-by-domain-theharvester() {
  local d && read "d?Domain: "
  print -z "theharvester -d ${d} -l 50 -b all -n -t -c -e 1.1.1.1"
}

qq-recon-screens-by-url-eyewitness(){
  local u && read "u?Url: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "eyewitness --web --user-agent \"${__UA}\" --single ${u} -d ./${d}/screens --no-dns --no-prompt "
}

qq-recon-screens-by-file-eyewitness(){
  local p && read "p?Path: "
  print -z "eyewitness --web --user-agent \"${__UA}\" -f ${p} -d ./screens --no-dns --no-prompt "
}

qq-recon-headers-curl() {
  local u && read "u?Url: "
  print -z "curl -X GET -I -L -A \"${__UA}\" ${u}"
}

