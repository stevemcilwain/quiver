#!/usr/bin/env zsh

############################################################# 
# qq-enum-kerb
#############################################################

qq-enum-kerb-sweep-nmap() {
  local s && read "s?SUBNET: "
  print -z "nmap -n -Pn -sS -p88 -oA kerb_sweep ${s} && grep open kerb_sweep.gnmap |cut -d' ' -f2 > kerb_hosts.txt"
}

qq-enum-kerb-tcpdump() {
  __info "Available: ${__IFACES}"
  local i && read "i?IFACE: "
  local r && read "r?RHOST: "
  print -z "tcpdump -i ${i} host ${r} and tcp port 88 -w kerb.${r}.pcap"
}

qq-enum-kerb-users() {
  local r && read "r?RHOST: "
  local realm && read "realm?REALM: "
  print -z "nmap -vvv -p 88 --script krb5-enum-users --script-args krb5-enum-users.realm=${realm},userdb=/usr/share/seclists/Usernames/Names/names.txt ${r}"
}

qq-enum-kerb-kerberoast() {
  local d && read "d?DOMAIN: "
  local u && read "u?SERVICE USER: "
  local dc && read "dc?DC(IP): "
  __warn "Ensure that the domain, ${d}, is in your hosts file."
  print -z "impacket-GetUserSPNs -request ${d}/${u} -dc-ip ${dc} "
}
