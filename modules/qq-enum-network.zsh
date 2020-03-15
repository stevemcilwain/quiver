#!/usr/bin/env zsh
 
############################################################# 
# qq-enum-network
#############################################################

qq-enum-network-ping-sweep() {
  __GET-NETWORK
  print -z "nmap -vvv -sn --open ${__NETWORK}"
}

qq-enum-network-syn-sweep() {
  __GET-NETWORK
  print -z "sudo nmap -vvv -n -Pn -sS --open  ${__NETWORK}"
}

qq-enum-network-udp-sweep() {
  __GET-NETWORK
  print -z "sudo nmap -vvv -n -Pn -sU --open --top-ports 100 ${__NETWORK}"
}

qq-enum-network-all-sweep() {
  __GET-NETWORK
  print -z "sudo nmap -vvv -n -Pn -T4 --open -sS -p- ${__NETWORK} "
}

qq-enum-network-discovery() {
  __GET-NETWORK
  print -z "nmap -vvv -n -Pn -sV -sC ${__NETWORK} "
}

__MASSCAN_PORTS="161,443,744,1433,1521,2075,2076,3000,3306,3366,3868,4000,4040,4044,4443,5000,5432,5900,6000,6443,7077,8000,8080,8081,8089,8181,8443,8888,9000,9091,9443,9999,27017,10000,15672"

qq-enum-network-masscan() {
  __GET-NETWORK
  print -z "sudo masscan ${__NETWORK} -p${__MASSCAN_PORTS} "
}
