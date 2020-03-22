#!/usr/bin/env zsh

############################################################# 
# qq-enum-ftp
#############################################################

qq-enum-ftp-sweep-nmap() {
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -p21 ${__NETWORK} -oA $(__netpath)/ftp-sweep"
}

qq-enum-ftp-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 21 -w $(__hostpath)/ftp.pcap"
}

qq-enum-ftp-hydra-brute() {
  qq-vars-set-rhost
  local u && read "u?$fg[cyan]USERNAME:$reset_color "
  print -z "hydra -l ${u} -P ${__PASSLIST} -f ${__RHOST} ftp -V -t 15 -o $(__hostpath)/ftp-hydra-brute.txt"
}

qq-enum-ftp-lftp-grep() {
  qq-vars-set-rhost
  print -z "lftp ${__RHOST}:/ > find | grep -i "
}

qq-enum-ftp-wget-mirror() {
  qq-vars-set-rhost
  print -z "wget --mirror ftp://anonymous:user@anon.com@${__RHOST}"
}
