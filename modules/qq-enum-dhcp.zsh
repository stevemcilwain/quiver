#!/usr/bin/env zsh

############################################################# 
# qq-enum-dhcp
#############################################################

qq-enum-dhcp-sweep-nmap() {
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sU -p67 ${__NETWORK} -oA $(__netpath)/dhcp-sweep"
}

qq-enum-dhcp-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and udp port 67 and port 68 -w $(__hostpath)/dhcp.pcap"
}

qq-enum-dhcp-discover-nmap() {
  print -z "sudo nmap -v --script broadcast-dhcp-discover"
}
