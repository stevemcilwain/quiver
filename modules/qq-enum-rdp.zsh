#!/usr/bin/env zsh

############################################################# 
# qq-enum-rdp
#############################################################

qq-enum-rdp-sweep-nmap() {
  __GET-NETWORK
  print -z "nmap -n -Pn -sS -p3389 ${__NETWORK}"
}

qq-enum-rdp-tcpdump() {
  __GET-IFACE
  __GET-RHOST
  print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 3389"
}

qq-enum-rdp-ncrack() {
  __GET-RHOST
  local u && read "u?USER: "
  print -z "ncrack -vv --user ${u} -P ${__PASS_ROCKYOU} rdp://${__RHOST}"
}

qq-enum-rdp-exploit-bluekeep() {
  __info "https://sploitus.com/exploit?id=EDB-ID:47683" 
}
