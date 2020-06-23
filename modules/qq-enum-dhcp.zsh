#!/usr/bin/env zsh

############################################################# 
# qq-enum-dhcp
#############################################################

qq-enum-dhcp-help() {
    cat << "DOC"

qq-enum-dhcp
-------------
The qq-enum-dhcp namespace contains commands for scanning and enumerating DHCP servers.

Commands
--------
qq-enum-dhcp-install:           installs dependencies
qq-enum-dhcp-nmap-sweep:        scan a network for services
qq-enum-dhcp-tcpdump:           capture traffic to and from a host
qq-enum-dhcp-discover-nmap:     broadcast DHCP discover packets

DOC
}

qq-enum-dhcp-install() {
    __info "Running $0..."
    __pkgs tcpdump nmap 
}

qq-enum-dhcp-sweep-nmap() {
    __check-project
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sU -p67 ${__NETWORK} -oA $(__netpath)/dhcp-sweep"
}

qq-enum-dhcp-tcpdump() {
    __check-project
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and udp port 67 and port 68 -w $(__hostpath)/dhcp.pcap"
}

qq-enum-dhcp-discover-nmap() {
    print -z "sudo nmap -v --script broadcast-dhcp-discover"
}
