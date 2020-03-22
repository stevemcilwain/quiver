#!/usr/bin/env zsh
 
############################################################# 
# qq-enum-network
#############################################################

qq-enum-network-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-network
  print -z "sudo tcpdump -i ${__IFACE} net ${__NETWORK} -w $(__netpath)/network.pcap"
}

qq-enum-network-tcpdump-bcasts() {
  qq-vars-set-iface
  print -z "sudo tcpdump -i ${__IFACE} ether broadcast and ether multicast -w $__OUTPUT/networks/bcasts.pcap"
}

qq-enum-network-nmap-ping-sweep() {
  qq-vars-set-network
  print -z "nmap -vvv -sn --open ${__NETWORK} -oA $(__netpath)/nmap-ping-sweep"
}

qq-enum-network-nmap-syn-sweep() {
  qq-vars-set-network
  print -z "sudo nmap -vvv -n -Pn -sS --open --top-ports 100 ${__NETWORK} -oA $(__netpath)/nmap-syn-sweep"
}

qq-enum-network-nmap-udp-sweep() {
  qq-vars-set-network
  print -z "sudo nmap -vvv -n -Pn -sU --open --top-ports 100 ${__NETWORK} -oA $(__netpath)/nmap-udp-sweep"
}

qq-enum-network-nmap-all-sweep() {
  qq-vars-set-network
  print -z "sudo nmap -vvv -n -Pn -T4 --open -sS -p- ${__NETWORK} -oA $(__netpath)/nmap-all-sweep"
}

qq-enum-network-nmap-discovery() {
  qq-vars-set-network
  print -z "nmap -vvv -n -Pn -sV -sC --top-ports 100 ${__NETWORK} -oA $(__netpath)/nmap-discovery"
}

__MASSCAN_PORTS="21,22,25,80,88,161,443,445,744,1433,1521,2075,2076,3000,3306,3366,3389,3868,4000,4040,4044,4443,5000,5432,5900,6000,6443,7077,8000,8080,8081,8089,8181,8443,8888,9000,9091,9443,9999,27017,10000,15672"

qq-enum-network-masscan-top() {
  qq-vars-set-network
  print -z "sudo masscan ${__NETWORK} -p${__MASSCAN_PORTS} -oL $(__netpath)/masscan-top.txt"
}

qq-enum-network-masscan-windows() {
  qq-vars-set-network
  print -z "sudo masscan ${__NETWORK} -p135-139,445,3389,389,636,88 -oL $(__netpath)/masscan-windows.txt"
}

qq-enum-network-masscan-linux() {
  qq-vars-set-network
  print -z "sudo masscan ${__NETWORK} -p22,111,2222 -oL $(__netpath)/masscan-linux.txt"
}

qq-enum-network-masscan-web() {
  qq-vars-set-network
  print -z "sudo masscan ${__NETWORK} -p80,800,8000,8080,8888,443,4433,4443 -oL $(__netpath)/masscan-web.txt"
}
