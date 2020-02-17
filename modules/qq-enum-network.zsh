#!/usr/bin/env zsh

############################################################# 
# qq-enum-network
#############################################################

qq-enum-network-1-ping-sweep() {
  local s && read "s?SUBNET: "
  print -z "nmap -vvv -sn --open -oA ping_sweep ${s} && cat ping_sweep.gnmap | grep Up | cut -d" " -f2 >> hosts.txt"
}

qq-enum-network-2-syn-sweep() {
  local s && read "s?SUBNET: "
  print -z "nmap -vvv -n -Pn --open -sS -oA syn_sweep --excludefile hosts.txt ${s} && cat syn_sweep.gnmap | grep Up | cut -d" " -f2 >> hosts.txt"
}

qq-enum-network-3-udp-sweep() {
  local s && read "s?SUBNET: "
  print -z "nmap -vvv -n -Pn --open -sU --top-ports 100 -oA udp_sweep --excludefile hosts.txt ${s} && cat udp_sweep.gnmap | grep Up | cut -d" " -f2 >> hosts.txt"
}

qq-enum-network-4-all-sweep() {
  local s && read "s?SUBNET: "
  print -z "nmap -vvv -n -Pn -T4 --open -sS -p- -oA syn_all --excludefile hosts.txt ${s} && cat syn_all.gnmap | grep Up | cut -d" " -f2 >> hosts.txt"
}

qq-enum-network-5-discovery() {
  print -z "nmap -vvv -n -Pn -sV -sC -iL hosts.txt -oA network_discovery && searchsploit -x --nmap network_discovery.xml |grep remote"
}

qq-enum-network-sort-hosts() {
  print -z "cat hosts.txt | sort -u | sort -V"
}

qq-enum-network-masscan() {
  local s && read "s?SUBNET: "
  print -z "masscan ${s} -p4443,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,443,744 "
}
