#!/usr/bin/env zsh

############################################################# 
# qq-enum-host
#############################################################

qq-enum-host-help() {
  cat << END

qq-enum-host
-------------
The qq-enum-host namespace contains commands for scanning and enumerating
an individual host.

Commands
--------
qq-enum-host-install:                 installs dependencies
qq-enum-host-tcpdump:                 capture traffic to and from a host
qq-enum-host-nmap-top:                syn scan of the top 1000 ports
qq-enum-host-nmap-top-discovery:      syn scan of the top 1000 ports with versioning and scripts
qq-enum-host-nmap-all:                syn scan all ports 
qq-enum-host-nmap-all-discovery:      syn scan all ports with versioning and scripts
qq-enum-host-nmap-udp:                udp scan top 100 ports
qq-enum-host-masscan-all-tcp:         scan all tcp ports
qq-enum-host-masscan-all-udp:         scan all udp ports
qq-enum-host-nmap-lse-grep:           search nmap lse scripts

END
}

qq-enum-host-install() {

  __pkgs tcpdump nmap masscan 

}

qq-enum-host-tcpdump() {
  __check-project
  __check-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} -w $(__hostpath)/tcpdump.pcap"
}

qq-enum-host-nmap-top(){
  __check-project
  qq-vars-set-rhost
  print -z "sudo nmap -vvv -Pn -sS --top-ports 1000 --open ${__RHOST} -oA $(__hostpath)/nmap-top"
}

qq-enum-host-nmap-top-discovery(){
  __check-project
  qq-vars-set-rhost
  print -z "sudo nmap -vvv -Pn -sS --top-ports 1000 --open -sC -sV ${__RHOST} -oA $(__hostpath)/nmap-top-discovery"
}

qq-enum-host-nmap-all() {
  __check-project
  qq-vars-set-rhost
  print -z "sudo nmap -vvv -Pn -sS -p- -T4 --open ${__RHOST} -oA $(__hostpath)/nmap-all"
}

qq-enum-host-nmap-all-discovery() {
  __check-project
  qq-vars-set-rhost
  print -z "sudo nmap -vvv -Pn -sS -p- -sC -sV --open ${__RHOST} -oA $(__hostpath)/nmap-all-discovery"
}

qq-enum-host-nmap-udp() {
  __check-project
  qq-vars-set-rhost
  print -z "sudo nmap -v -Pn -sU --top-ports 100 -sV -sC --open ${__RHOST} -oA $(__hostpath)/nmap-udp"
}

qq-enum-host-masscan-all-tcp() {
  __check-iface
  __check-project
  qq-vars-set-rhost
  print -z "masscan -p1-65535 --open-only ${__RHOST} --rate=1000 -e ${__IFACE} -oL $(__hostpath)/masscan-all-tcp.txt"
}

qq-enum-host-masscan-all-udp() {
  __check-iface
  __check-project
  qq-vars-set-rhost
  print -z "masscan -pU:1-65535 --open-only ${__RHOST} --rate=1000 -e ${__IFACE} -oL $(__hostpath)/masscan-all-udp.txt"
}

qq-enum-host-nmap-lse-grep() {
  print -z "ls /usr/share/nmap/scripts/* | grep <pattern>"
}
