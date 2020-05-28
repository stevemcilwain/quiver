#!/usr/bin/env zsh

############################################################# 
# qq-enum-pop3
#############################################################

qq-enum-pop3-help() {
  cat << "DOC"

qq-enum-pop3
------------
The qq-enum-pop3 namespace contains commands for scanning 
and enumerating POP3 email services.

Commands
--------
qq-enum-pop3-install:     installs dependencies
qq-enum-pop3-nmap-sweep:  scan a network for services
qq-enum-pop3-tcpdump:     capture traffic to and from a host
qq-enum-pop3-hydra:       brute force passwords for a user account

DOC
}

qq-enum-pop3-install() {
    __pkgs nmap tcpdump hydra
}

qq-enum-pop3-nmap-sweep() {
  __check-project
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -p 110,995 ${__NETWORK} -oA $(__netpath)/pop3-sweep"
}

qq-enum-pop3-tcpdump() {
  __check-project
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 110 and port 995 -w $(__hostpath)/pop3.pcap"
}

qq-enum-pop3-hydra() {
  __check-project
  qq-vars-set-rhost
  __check-user
  print -z "hydra -l ${__USER} -P ${__PASSLIST} -e -o $(__hostpath)/pop3-hydra-brute.txt ${__RHOST} POP3"
}



