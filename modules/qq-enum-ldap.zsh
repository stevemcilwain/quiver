#!/usr/bin/env zsh

############################################################# 
# qq-enum-ldap
#############################################################

qq-enum-ldap-sweep-nmap() {
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sS -sU -p389,636,3269 ${__NETWORK} -oA $(__netpath)/ldap-sweep"
}

qq-enum-ldap-tcpdump() {
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 389 and port 636 and port 3269 -w $(__hostpath)/ldap.pcap"
}

qq-enum-ldap-ctx() {
    qq-vars-set-rhost
    print -z "ldapsearch -x -h ${__RHOST} -s base namingcontexts"
}

qq-enum-ldap-search-by-dn() {
    qq-vars-set-rhost
    local dn && read "dn?$fg[cyan]DN(DC=domain,DC=com):$reset_color "
    print -z "ldapsearch -x -h ${__RHOST} -s sub -b '${dn}' "
}

qq-enum-ldap-search-all() {
    qq-vars-set-rhost
    local dn && read "dn?$fg[cyan]DN(DC=domain,DC=com):$reset_color "
    local u && read "u?$fg[cyan]USER: "
    print -z "ldapsearch -x -h ${__RHOST} -D '${dn}' \"(objectClass=*)\" -w \"${u}\" "
}

qq-enum-ldap-whoami() {
    qq-vars-set-rhost
    print -z "ldapwhoami -h ${__RHOST} -w \"non-existing-user\" "
}
