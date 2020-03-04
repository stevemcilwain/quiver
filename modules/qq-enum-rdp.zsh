#!/usr/bin/env zsh

############################################################# 
# qq-enum-rdp
#############################################################

qq-enum-rdp-sweep-nmap() {
  local s && read "s?SUBNET: "
  print -z "nmap -n -Pn -sS -p3389 -oA rdp_sweep ${s} &&  grep open rdp_sweep.gnmap |cut -d' ' -f2 > rdp_hosts.txt"
}

qq-enum-rdp-tcpdump() {
  __info "Available: ${__IFACES}"
  local i && read "i?IFACE: "
  local r && read "r?RHOST: "
  print -z "tcpdump -i ${i} host ${r} and tcp port 3389 -w rdp.${r}.pcap"
}

qq-enum-rdp-ncrack() {
  local r && read "r?RHOST: "
  local u && read "u?USER: "
  print -z "ncrack -vv --user ${u} -P ${__PASS_ROCKYOU} rdp://${r}"
}

qq-enum-rdp-exploit-bluekeep() {
  __info "https://sploitus.com/exploit?id=EDB-ID:47683" 
}
