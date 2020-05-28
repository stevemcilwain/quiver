#!/usr/bin/env zsh

############################################################# 
# qq-enum-oracle
#############################################################

qq-enum-oracle-help() {
  cat << "DOC"

qq-enum-oracle
--------------s
The qq-enum-oracle namespace contains commands for scanning and 
enumerating Oracle services and databases.

Commands
--------
qq-enum-oracle-install:           installs dependencies
qq-enum-oracle-nmap-sweep:        scan a network for services
qq-enum-oracle-tcpdump:           capture traffic to and from a host
qq-enum-oracle-sqlplus:           sqlplus client
qq-enum-oracle-odat:              odat anonymous enumeration
qq-enum-oracle-odat-creds:        odat authenticated enumeration
qq-enum-oracle-odat-passwords:    odat password brute
qq-enum-oracle-version:           tnscmd version query
qq-enum-oracle-status:            tnscmd status query
qq-enum-oracle-sidguess:          tnscmd password brute force
qq-enum-oracle-oscanner:          oscanner enumeration
qq-enum-oracle-hydra-listener:    brute force passwords 
qq-enum-oracle-hydra-sid:         brute force passwords

DOC
}

qq-enum-oracle-install() {

  __pkgs tcpdump nmap odat tnscmd10g sidguess oscanner hydra
  __pkgs oracle-instantclient-sqlplus 
  sudo sh -c "echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf"; sudo ldconfig
}


qq-enum-oracle-nmap-sweep() {
  __check-project
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -p 1521 ${__NETWORK} -oA $(__netpath)/oracle-sweep"
}

qq-enum-oracle-tcpdump() {
  __check-project
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 1521 -w $(__hostpath)/oracle.pcap"
}

qq-enum-oracle-sqlplus() {
  qq-vars-set-rhost
  local sid && __askvar sid "SID(DATABASE)"
  local u && __askvar u "USER"
  local p && __askvar [u] "PASSWORD"
  print -z "sqlplus ${u}/${p}@${__RHOST}:1521/${sid} as sysdba"
}

qq-enum-oracle-odat() {
  qq-vars-set-rhost
  print -z "odat all -s ${__RHOST}"
}

qq-enum-oracle-odat-creds() {
  qq-vars-set-rhost
  local sid && __askvar sid "SID(DATABASE)"
  local u && __askvar u "USER"
  local p && __askvar [u] "PASSWORD"
  print -z "odat all -s ${__RHOST} -p 1521 -d ${sid} -U ${u} -P ${p}"
}

qq-enum-oracle-odat-passwords() {
  qq-vars-set-rhost
  local sid && __askvar sid "SID(DATABASE)"
  __info "cat /usr/share/metasploit-framework/data/wordlists/oracle_default_userpass.txt | sed -e "s/[[:space:]]/\\\/g""
  print -z "odat passwordguesser -s ${__RHOST} -d ${sid} --accounts-file accounts.txt"
}

qq-enum-oracle-version(){
  qq-vars-set-rhost
  print -z "tnscmd10g version -h ${__RHOST}"
}

qq-enum-oracle-status(){
  qq-vars-set-rhost
  print -z "tnscmd10g status -h ${__RHOST}"
}

qq-enum-oracle-sidguess(){
  qq-vars-set-rhost
  print -z "sidguess host=${__RHOST} port=1521 sidfile=sid.txt"
}

qq-enum-oracle-oscanner() {
  qq-vars-set-rhost
  print -z "oscanner -s ${__RHOST}"
}

qq-enum-oracle-hydra-listener() {
  __check-project
  qq-vars-set-rhost
  __check-user
  print -z "hydra -l ${__USER} -P ${__PASSLIST} -e -o $(__hostpath)/oracle-listener-hydra-brute.txt ${__RHOST} Oracle Listener"
}

qq-enum-oracle-hydra-sid() {
  __check-project
  qq-vars-set-rhost
  __check-user
  print -z "hydra -l ${__USER} -P ${__PASSLIST} -e -o $(__hostpath)/oracle-sid-hydra-brute.txt ${__RHOST} Oracle Sid"
}


