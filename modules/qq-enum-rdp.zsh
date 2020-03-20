#!/usr/bin/env zsh

############################################################# 
# qq-enum-rdp
#############################################################

qq-enum-rdp-sweep-nmap() {
  qq-vars-set-network
  print -z "nmap -n -Pn -sS -p3389 ${__NETWORK} -oA $(__netpath)/rdp-sweep"
}

qq-enum-rdp-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 3389 -w $(__hostpath)/rdp.pcap"
}

qq-enum-rdp-ncrack() {
  qq-vars-set-rhost
  local u && read "u?$fg[cyan]USER:$reset_color "
  print -z "ncrack -vv --user ${u} -P ${__PASSLIST} rdp://${__RHOST}"
}

qq-enum-rdp-exploit-bluekeep() {
  __info "https://sploitus.com/exploit?id=EDB-ID:47683" 
}
