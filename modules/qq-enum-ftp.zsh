#!/usr/bin/env zsh

############################################################# 
# qq-enum-ftp
#############################################################

qq-enum-ftp-sweep-nmap() {
  __GET-NETWORK
  print -z "sudo nmap -n -Pn -sS -p21 ${__NETWORK}"
}

qq-enum-ftp-tcpdump() {
  __GET-IFACE
  __GET-RHOST
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 21"
}

qq-enum-ftp-brute-hydra() {
  __GET-RHOST
  local u && read "u?USERNAME: "
  print -z "hydra -l ${u} -P ${__PASS_ROCKYOU} -f ${__RHOST} ftp -V -t 15"
}

qq-enum-ftp-lftp-grep() {
  __GET-RHOST
  print -z "lftp ${__RHOST}:/ > find | grep -i "
}

qq-enum-ftp-wget-mirror() {
  __GET-RHOST
  print -z "wget --mirror ftp://anonymous:user@anon.com@${__RHOST}"
}
