#!/usr/bin/env zsh

############################################################# 
# qq-enum-ldap
#############################################################

qq-enum-ldap-help() {
  cat << END

qq-enum-ldap
------------
The qq-enum-ldap namespace contains commands for scanning and 
enumerating Active Directory DC, GC and LDAP servers.

Commands
--------
qq-enum-ldap-install:        installs dependencies
qq-enum-ldap-nmap-sweep:     scan a network for services
qq-enum-ldap-tcpdump:        capture traffic to and from a host
qq-enum-ldap-ctx:            query ldap naming contexts
qq-enum-ldap-search-anon:    connect with anonymous bind and query ldap
qq-enum-ldap-search-auth:    connect with authenticated bind and query ldap
qq-enum-ldap-whoami:         send ldap whoami request
qq-enum-ldap-hydra:          brute force passwords for a user account

END
}

qq-enum-ldap-install() {

  __pkgs tcpdump nmap ldap-utils hydra

}

qq-enum-ldap-nmap-sweep() {
    __check-project
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sS -sU -p389,636,3269 ${__NETWORK} -oA $(__netpath)/ldap-sweep"
}

qq-enum-ldap-tcpdump() {
    __check-project
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 389 and port 636 and port 3269 -w $(__hostpath)/ldap.pcap"
}

qq-enum-ldap-ctx() {
    __ask "Enter the address of the target DC, GC or LDAP server"
    qq-vars-set-rhost
    print -z "ldapsearch -x -h ${__RHOST} -s base namingcontexts"
}

qq-enum-ldap-search-anon() {
    __ask "Enter the address of the target DC, GC or LDAP server"
    qq-vars-set-rhost
    __ask "Enter a distinguished name (DN), such as: DC=example,DC=com"
    local dn && __askvar dn DN
    print -z "ldapsearch -x -h ${__RHOST} -s sub -b \"${dn}\" "
}

qq-enum-ldap-search-auth() {
    __ask "Enter the address of the target DC, GC or LDAP server"
    qq-vars-set-rhost
    __ask "Enter a distinguished name (DN), such as: DC=example,DC=com"
    local dn && __askvar dn DN
    __ask "Enter a user account with bind and read permissions to the directory"
    __check-user
    print -z "ldapsearch -x -h ${__RHOST} -D '${dn}' \"(objectClass=*)\" -w \"${__USER}\" "
}

qq-enum-ldap-whoami() {
    __ask "Enter the address of the target DC, GC or LDAP server"
    qq-vars-set-rhost
    print -z "ldapwhoami -h ${__RHOST} -w \"non-existing-user\" "
}

qq-enum-ldap-hydra() {
  __check-project
  qq-vars-set-rhost
  __check-user
  print -z "hydra -l ${__USER} -P ${__PASSLIST} -e -o $(__hostpath)/ldap-hydra-brute.txt ${__RHOST} LDAP"
}
