#!/usr/bin/env zsh
 
############################################################# 
# qq-enum-dns
#############################################################

qq-enum-dns-sweep-nmap() {
  __GET-NETWORK
  print -z "sudo nmap -n -Pn -sS -sU -p53 ${__NETWORK}"
}

qq-enum-dns-tcpdump() {
  __GET-IFACE
  __GET-RHOST
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 53"
}

qq-enum-dns-txfr-dig() {
  __GET-RHOST
  local zone && read "zone?ZONE: "
  print -z "dig axfr @${__RHOST} ${zone}"
}

qq-enum-dns-txfr-host() {
  __GET-RHOST
  local zone && read "zone?ZONE: "
  print -z "host -l ${zone} ${__RHOST}"
}

qq-enum-dns-brute-rev() {
  __GET-RHOST
  local network && read "network?NETWORK(ex: 10.10.10): "
  print -z "for h in {1..254}; do host ${network}.$h ${__RHOST}; done | grep pointer"
}


