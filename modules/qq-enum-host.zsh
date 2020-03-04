#!/usr/bin/env zsh

############################################################# 
# qq-enum-host
#############################################################

qq-enum-host-tcpdump() {
  __info "Available: ${__IFACES}"
  local i && read "i?IFACE: "
  local r && read "r?RHOST: "
  print -z "sudo tcpdump -i ${i} host ${r} -w host.${r}.pcap"
}

qq-enum-host-basic-nmap(){
  local r && read "r?RHOST: "
  print -z "nmap -vvv -Pn -sC -sV --open -oA scan.${r}.top ${r}"
}

qq-enum-host-syn-all-nmap() {
  local r && read "r?RHOST: "
  print -z "sudo nmap -vvv -n -Pn -sS -T4 --open -oA scan.${r}.syn -p- ${r}"
}

qq-enum-host-svc-all-nmap() {
  local r && read "r?RHOST: "
  print -z "sudo nmap -vvv -n -Pn -sS -sC -sV --open -oA scan.${r}.svc -p- ${r}"
}

qq-enum-host-udp-nmap() {
  local r && read "r?RHOST: "
  print -z "sudo nmap -n -Pn -sU -sV -sC --open -oA scan.${r}.udp --top-ports 100 ${r}"
}

qq-enum-host-lse-grep() {
  print -z "ls /usr/share/nmap/scripts/* | grep <pattern>"
}
