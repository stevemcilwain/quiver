#!/usr/bin/env zsh

############################################################# 
# qq-enum-oracle
#############################################################

qq-enum-oracle-sweep-nmap() {
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sS -p 1521 ${__NETWORK} -oA $(__netpath)/oracle-sweep"
}

qq-enum-oracle-tcpdump() {
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 1521 -w $(__hostpath)/oracle.pcap"
}


qq-enum-oracle-install() {
  print -z "apt-get install odat oracle-instantclient12.1-devel tnscmd10g sidguess oscanner"
}

qq-enum-oracle-sqlplus() {
  qq-vars-set-rhost
  local sid && read "sid?$fg[cyan]SID:$reset_color "
  local u && read "u?$fg[cyan]USER:$reset_color "
  local p && read "p?$fg[cyan]PASSWORD:$reset_color "
  print -z "sqlplus ${u}/${p}@${__RHOST}:1521/${sid} as sysdba"
}

qq-enum-oracle-odat() {
  qq-vars-set-rhost
  print -z "odat all -s ${__RHOST}"
}

qq-enum-oracle-odat-creds() {
  qq-vars-set-rhost
  local sid && read "sid?$fg[cyan]SID:$reset_color "
  local u && read "u?$fg[cyan]USER:$reset_color "
  local p && read "p?$fg[cyan]Password:$reset_color "
  print -z "./odat.py all -s ${__RHOST} -p 1521 -d ${sid} -U ${u} -P ${p}"
}

qq-enum-oracle-odat-password-guesser() {
  qq-vars-set-rhost
  local sid && read "sid?$fg[cyan]SID:$reset_color "
  __info "cat oracle_default_userpass.txt | sed -e "s/[[:space:]]/\\\/g""
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

qq-enum-mysql-hydra() {
  qq-vars-set-rhost
  local user && read "user?$fg[cyan]USER:$reset_color "
  hydra -l ${user} -P /usr/share/wordlists/rockyou.txt ${__RHOST} oracle
}
