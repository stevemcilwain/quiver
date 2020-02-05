#!/usr/bin/env zsh

############################################################# 
# Enum - DNS
#############################################################

qq-enum-dns-sweep-nmap() {
  local s && read "s?Subnet (range): "
  print -z "nmap -n -Pn -sS -sU -p53 -oA dns_sweep ${s} && grep open dns_sweep.gnmap |cut -d' ' -f2 > dns_hosts.txt"
}

qq-enum-dns-tcpdump() {
    info "${__IFACES}"
    local r && read "r?Remote Host: "
    local i && read "i?Interface: "
  print -z "tcpdump -i ${i} host ${r} and tcp port 53 -w dns.${r}.pcap"
}

qq-enum-dns-txfr-dig() {
  local server && read "server?Server: "
  local zone && read "zone?Zone (range): "
  print -z "dig axfr @${server} ${zone}"
}

qq-enum-dns-txfr-host() {
  local server && read "server?Server: "
  local zone && read "zone?Zone (range): "
  print -z "host -l ${zone} ${server}"
}

qq-enum-dns-brute-rev() {
  local server && read "server?Server: "
  local network && read "network?Network (ex: 10.10.10): "
  print -z "for h in {1..254}; do host ${network}.$h ${server}; done | grep pointer > revdns.${network}.txt"
}


