#!/usr/bin/env zsh

############################################################# 
# qq-enum-mssql
#############################################################

qq-enum-mssql-sweep-nmap() {
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sS -sU -p T:1433,U:1434 ${__NETWORK} -oA $(__netpath)/mssql-sweep"
}

qq-enum-mssql-tcpdump() {
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 1433 -w $(__hostpath)/mssql.pcap"
}

qq-enum-mssql-sqsh() {
  qq-vars-set-rhost
  local u && read "u?$fg[cyan]USER:$reset_color "
  print -z "sqsh -S ${__RHOST} -U ${u}"
}

qq-enum-mssql-impacket-client() {
  qq-vars-set-rhost
  local u && read "u?$fg[cyan]USER:$reset_color "
  local db && read "db?$fg[cyan]DATABASE:$reset_color "
  print -z "python3 ${__IMPACKET}/mssqlclient.py ${u}@${__RHOST} -db ${db} -windows-auth "
}