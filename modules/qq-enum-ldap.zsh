#!/usr/bin/env zsh

############################################################# 
# qq-enum-ldap
#############################################################

qq-enum-ldap-sweep-nmap() {
    __GET-NETWORK
    print -z "sudo nmap -n -Pn -sS -sU -p389,636 ${__NETWORK}"
}

qq-enum-ldap-tcpdump() {
    __GET-IFACE
    __GET-RHOST
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 389 and port 636"
}

qq-enum-ldap-ctx() {
    __GET-RHOST
    print -z "ldapsearch -x -h ${__RHOST} -s base namingcontexts"
}

qq-enum-ldap-search-by-dn() {
    __GET-RHOST
    local dn && read "dn?DN(DC=domain,DC=com): "
    print -z "ldapsearch -x -h ${__RHOST} -s sub -b '${dn}' "
}

qq-enum-ldap-search-all() {
    __GET-RHOST
    local dn && read "dn?DN(DC=domain,DC=com): "
    local u && read "u?USER: "
    print -z "ldapsearch -x -h ${__RHOST} -D '${dn}' \"(objectClass=*)\" -w \"${u}\" "
}

qq-enum-ldap-whoami() {
    __GET-RHOST
    print -z "ldapwhoami -h ${__RHOST} -w \"non-existing-user\" "
}
