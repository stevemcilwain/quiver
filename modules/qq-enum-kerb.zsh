#!/usr/bin/env zsh

############################################################# 
# qq-enum-kerb
#############################################################

qq-enum-kerb-help() {
    cat << "DOC"

qq-enum-kerb
------------
The qq-enum-kerb namespace contains commands for scanning and 
enumerating kerberos records and servers.

Commands
--------
qq-enum-kerb-install:        installs dependencies
qq-enum-kerb-nmap-sweep:     scan a network for services
qq-enum-kerb-tcpdump:        capture traffic to and from a host
qq-enum-kerb-users:          enumerate domain users
qq-enum-kerb-kerberoast:     get SPN for a service account

DOC
}

qq-enum-kerb-install() {
    __info "Running $0..."
    __pkgs tcpdump nmap impacket-scripts   
}

qq-enum-kerb-nmap-sweep() {
    __check-project
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sS -p88 ${__NETWORK} -oA $(__netpath)/kerb-sweep"
}

qq-enum-kerb-tcpdump() {
    __check-project
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 88 -w $(__hostpath)/kerb.pcap"
}

qq-enum-kerb-users() {
    qq-vars-set-rhost
    local realm && __askvar realm REALM
    print -z "nmap -vvv -p 88 --script krb5-enum-users --script-args krb5-enum-users.realm=${realm},userdb=/usr/share/seclists/Usernames/Names/names.txt ${__RHOST}"
}

qq-enum-kerb-kerberoast() {
    __ask "Enter target AD domain (must also be set in your hosts file)"
    qq-vars-set-domain
    __ask "Enter service user account"
    __check-user
    __ask "Enter the IP address of the target domain controller"
    qq-vars-set-rhost
    print -z "impacket-GetUserSPNs -request ${__DOMAIN}s/${__USER} -dc-ip ${__RHOST} "
}
