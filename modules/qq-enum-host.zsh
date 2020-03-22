#!/usr/bin/env zsh

############################################################# 
# qq-enum-host
#############################################################

qq-enum-host-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} -w $(__hostpath)/tcpdump.pcap"
}

qq-enum-host-nmap-top(){
  qq-vars-set-rhost
  print -z "sudo nmap -vvv -Pn -sS --top-ports 1000 --open ${__RHOST} -oA $(__hostpath)/nmap-top"
}

qq-enum-host-nmap-top-discovery(){
  qq-vars-set-rhost
  print -z "sudo nmap -vvv -Pn -sS --top-ports 1000 --open -sC -sV ${__RHOST} -oA $(__hostpath)/nmap-top-discovery"
}

qq-enum-host-nmap-all() {
  qq-vars-set-rhost
  print -z "sudo nmap -vvv -Pn -sS -p- -T4 --open ${__RHOST} -oA $(__hostpath)/nmap-all"
}

qq-enum-host-nmap-all-discovery() {
  qq-vars-set-rhost
  print -z "sudo nmap -vvv -Pn -sS -p- -sC -sV --open ${__RHOST} -oA $(__hostpath)/nmap-all-discovery"
}

qq-enum-host-nmap-udp() {
  qq-vars-set-rhost
  print -z "sudo nmap -v -Pn -sU --top-ports 100 -sV -sC --open ${__RHOST} -oA $(__hostpath)/nmap-udp"
}

qq-enum-host-masscan-all-tcp() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "masscan -p1-65535 --open-only ${__RHOST} --rate=1000 -e ${__IFACE} -oL $(__hostpath)/masscan-all-tcp.txt"
}

qq-enum-host-masscan-all-udp() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "masscan -pU:1-65535 --open-only ${__RHOST} --rate=1000 -e ${__IFACE} -oL $(__hostpath)/masscan-all-udp.txt"
}

qq-enum-host-nmap-lse-grep() {
  print -z "ls /usr/share/nmap/scripts/* | grep <pattern>"
}
