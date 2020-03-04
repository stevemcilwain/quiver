#!/usr/bin/env zsh

############################################################# 
# qq-enum-ldap
#############################################################

qq-enum-ldap-sweep-nmap() {
    local s && read "s?SUBNET: "
    print -z "sudo nmap -n -Pn -sS -sU -p389,636 -oA ldap_sweep ${s} &&  grep open ldap_sweep.gnmap |cut -d' ' -f2 >> ldap_hosts.txt"
}

qq-enum-ldap-tcpdump() {
    __info "Available: ${__IFACES}"
    local i && read "i?IFACE: "
    local r && read "r?RHOST: "
    print -z "sudo tcpdump -i ${i} host ${r} and tcp port 389 and port 636 -w ldap.${__RHOST}.pcap"
}

qq-enum-ldap-ctx() {
    local r && read "r?RHOST: "
    print -z "ldapsearch -x -h ${r} -s base namingcontexts"
}

qq-enum-ldap-search() {
    local r && read "r?RHOST: "
    local dn && read "dn?DN(DC=domain,DC=com): "
    print -z "ldapsearch -x -h ${r} -s sub -b '${dn}'"
}