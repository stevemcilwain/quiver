#!/usr/bin/env zsh

############################################################# 
# qq-enum-nfs
#############################################################

qq-enum-nfs-sweep-nmap() {
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -sU -p U:111,T:111,U:2049,T:2049 ${__NETWORK} -oA $(__netpath)/nfs-sweep"
}

qq-enum-nfs-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 111 and port 2049 -w $(__hostpath)/nfs.pcap"
}

qq-enum-nfs-show() {
  qq-vars-set-rhost
  print -z "showmount -e ${__RHOST}"
}

qq-enum-nfs-mount() {
  qq-vars-set-rhost
  local share && read "share?$fg[cyan]SHARE:$reset_color "
  print -z "mkdir /mnt/${share} && mount -t nfs ${__RHOST}:/${share} /mnt/${share} -o nolock"
}
