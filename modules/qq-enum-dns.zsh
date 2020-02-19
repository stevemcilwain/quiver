#!/usr/bin/env zsh

############################################################# 
# qq-enum-dns
#############################################################

qq-enum-dns-sweep-nmap() {
  local s && read "s?SUBNET: "
  print -z "sduo nmap -n -Pn -sS -sU -p53 -oA dns_sweep ${s} && grep open dns_sweep.gnmap |cut -d' ' -f2 > dns_hosts.txt"
}

qq-enum-dns-tcpdump() {
  __info "Available: ${__IFACES}"
  local i && read "i?IFACE: "
  local r && read "r?RHOST: "
  print -z "sudo tcpdump -i ${i} host ${r} and tcp port 53 -w dns.${r}.pcap"
}

qq-enum-dns-txfr-dig() {
  local server && read "server?SERVER: "
  local zone && read "zone?ZONE: "
  print -z "dig axfr @${server} ${zone}"
}

qq-enum-dns-txfr-host() {
  local server && read "server?SERVER: "
  local zone && read "zone?ZONE: "
  print -z "host -l ${zone} ${server}"
}

qq-enum-dns-brute-rev() {
  local server && read "server?SERVER: "
  local network && read "network?NETWORK(ex: 10.10.10): "
  print -z "for h in {1..254}; do host ${network}.$h ${server}; done | grep pointer > revdns.${network}.txt"
}


