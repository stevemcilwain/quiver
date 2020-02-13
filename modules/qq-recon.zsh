#!/usr/bin/env zsh

############################################################# 
# qq-recon
#############################################################

qq-recon-script-webrecon() {
  local f && read "f?File: "
  __warn "Uses your current directory for output"
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



