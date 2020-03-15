#!/usr/bin/env zsh

############################################################# 
# qq-enum-host
#############################################################

qq-enum-host-tcpdump() {
  __GET-IFACE
  __GET-RHOST
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST}"
}

qq-enum-host-basic-nmap(){
  __GET-RHOST
  print -z "nmap -vvv -Pn -sC -sV --open ${__RHOST}"
}

qq-enum-host-syn-all-nmap() {
  __GET-RHOST
  print -z "sudo nmap -vvv -n -Pn -sS -T4 --open -p- ${__RHOST}"
}

qq-enum-host-svc-all-nmap() {
  __GET-RHOST
  print -z "sudo nmap -vvv -n -Pn -sS -sC -sV --open -p- ${__RHOST}"
}

qq-enum-host-udp-nmap() {
  __GET-RHOST
  print -z "sudo nmap -n -Pn -sU -sV -sC --open --top-ports 100 ${__RHOST}"
}

qq-enum-host-all-masscan() {
  __GET-IFACE
  __GET-RHOST
  print -z "masscan -p1-65535,U:1-65535 ${__RHOST} --rate=1000 -e ${__IFACE}"
}

qq-enum-host-lse-grep() {
  print -z "ls /usr/share/nmap/scripts/* | grep <pattern>"
}
