#!/usr/bin/env zsh
 
############################################################# 
# qq-enum-network
#############################################################

qq-enum-network-help() {
  cat << END

qq-enum-network
-------------
The qq-enum-network namespace contains commands for scanning and enumerating
a network.

Commands
--------
qq-enum-network-install:              installs dependencies
qq-enum-network-tcpdump:              capture traffic to and from a network
qq-enum-network-tcpdump-bcasts:       capture ethernet broadcasts and multi-cast traffic
qq-enum-network-nmap-ping-sweep:      sweep a network with ping requests
qq-enum-network-nmap-syn-sweep:       sweep a network with TCP syn requests, top 1000 ports
qq-enum-network-nmap-udp-sweep:       sweep a network with UDP requests, top 100 ports
qq-enum-network-nmap-all-sweep:       sweep a network with TCP syn requests, all ports
qq-enum-network-nmap-discovery:       sweep a network with TCP syn requests and scripts, top 100 ports
qq-enum-network-masscan-top:          sweep a network with TCP requests, uses $__TCP_PORTS global var
qq-enum-network-masscan-windows:      sweep a network for common Windows ports
qq-enum-network-masscan-linux:        sweep a network for common Linux ports
qq-enum-network-masscan-web:          sweep a network for common web server ports

END
}

qq-enum-network-install() {

  __pkgs tcpdump nmap masscan 

}


qq-enum-network-tcpdump() {
  __check-project
  qq-vars-set-iface
  qq-vars-set-network
  print -z "sudo tcpdump -i ${__IFACE} net ${__NETWORK} -w $(__netpath)/network.pcap"
}

qq-enum-network-tcpdump-bcasts() {
  __check-project
  qq-vars-set-iface
  print -z "sudo tcpdump -i ${__IFACE} ether broadcast and ether multicast -w $__PROJECT/networks/bcasts.pcap"
}

qq-enum-network-nmap-ping-sweep() {
  __check-project
  qq-vars-set-network
  print -z "nmap -vvv -sn --open ${__NETWORK} -oA $(__netpath)/nmap-ping-sweep"
}

qq-enum-network-nmap-syn-sweep() {
  __check-project
  qq-vars-set-network
  print -z "sudo nmap -vvv -n -Pn -sS --open --top-ports 100 ${__NETWORK} -oA $(__netpath)/nmap-syn-sweep"
}

qq-enum-network-nmap-udp-sweep() {
  __check-project
  qq-vars-set-network
  print -z "sudo nmap -vvv -n -Pn -sU --open --top-ports 100 ${__NETWORK} -oA $(__netpath)/nmap-udp-sweep"
}

qq-enum-network-nmap-all-sweep() {
  __check-project
  qq-vars-set-network
  print -z "sudo nmap -vvv -n -Pn -T4 --open -sS -p- ${__NETWORK} -oA $(__netpath)/nmap-all-sweep"
}

qq-enum-network-nmap-discovery() {
  __check-project
  qq-vars-set-network
  print -z "nmap -vvv -n -Pn -sV -sC --top-ports 100 ${__NETWORK} -oA $(__netpath)/nmap-discovery"
}

qq-enum-network-masscan-top() {
  __check-project
  qq-vars-set-network
  print -z "sudo masscan ${__NETWORK} -p${__TCP_PORTS} -oL $(__netpath)/masscan-top.txt"
}

qq-enum-network-masscan-windows() {
  __check-project
  qq-vars-set-network
  print -z "sudo masscan ${__NETWORK} -p135-139,445,3389,389,636,88 -oL $(__netpath)/masscan-windows.txt"
}

qq-enum-network-masscan-linux() {
  __check-project
  qq-vars-set-network
  print -z "sudo masscan ${__NETWORK} -p22,111,2222 -oL $(__netpath)/masscan-linux.txt"
}

qq-enum-network-masscan-web() {
  __check-project
  qq-vars-set-network
  print -z "sudo masscan ${__NETWORK} -p80,800,8000,8080,8888,443,4433,4443 -oL $(__netpath)/masscan-web.txt"
}
