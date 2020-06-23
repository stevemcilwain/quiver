#!/usr/bin/env zsh

############################################################# 
# qq-enum-nfs
#############################################################

qq-enum-nfs-help() {
    cat << "DOC"

qq-enum-nfs
-----------
The qq-enum-nfs namespace contains commands for scanning and 
enumerating NFS services.

Commands
--------
qq-enum-nfs-install:        installs dependencies
qq-enum-nfs-nmap-sweep:     scan a network for services
qq-enum-nfs-tcpdump:        capture traffic to and from a host
qq-enum-nfs-show:           show remote NFS shares
qq-enum-nfs-mount:          mount a remote NFS share locally

DOC
}

qq-enum-nfs-install() {
    __info "Running $0..."
    __pkgs tcpdump nmap nfs-common
}

qq-enum-nfs-nmap-sweep() {
    __check-project
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sS -sU -p U:111,T:111,U:2049,T:2049 ${__NETWORK} -oA $(__netpath)/nfs-sweep"
}

qq-enum-nfs-tcpdump() {
    __check-project
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 111 and port 2049 -w $(__hostpath)/nfs.pcap"
}

qq-enum-nfs-show() {
    qq-vars-set-rhost
    print -z "showmount -e ${__RHOST}"
}

qq-enum-nfs-mount() {
    qq-vars-set-rhost
    local share && __askvar share SHARE
    mkdir -p /mnt/${share}
    print -z "mount -t nfs ${__RHOST}:/${share} /mnt/${share} -o nolock"
}
