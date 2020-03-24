#!/usr/bin/env zsh

############################################################# 
# qq-enum-pop3
#############################################################

qq-enum-pop3-sweep-nmap() {
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -p 110,995 ${__NETWORK} -oA $(__netpath)/pop3-sweep"
}

qq-enum-pop3-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 110 and port 995 -w $(__hostpath)/pop3.pcap"
}


