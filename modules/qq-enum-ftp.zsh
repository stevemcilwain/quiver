#!/usr/bin/env zsh

############################################################# 
# qq-enum-ftp
#############################################################

qq-enum-ftp-help() {
    cat << "DOC"

qq-enum-ftp
-------------
The qq-enum-ftp namespace contains commands for scanning and enumerating FTP servers.

Commands
--------
qq-enum-ftp-install:           installs dependencies
qq-enum-ftp-nmap-sweep:        scan a network for services
qq-enum-ftp-tcpdump:           capture traffic to and from a host
qq-enum-ftp-hydra:             brute force passwords for a user account
qq-enum-ftp-lftp-grep:         search (grep) the target system
qq-enum-ftp-wget-mirror:       mirror the FTP server locally

DOC
}

qq-enum-ftp-install() {
    __info "Running $0..."
    __pkgs tcpdump nmap hydra ftp lftp wget 
}

qq-enum-ftp-sweep-nmap() {
    __check-project
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sS -p21 ${__NETWORK} -oA $(__netpath)/ftp-sweep"
}

qq-enum-ftp-tcpdump() {
    __check-project
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 21 -w $(__hostpath)/ftp.pcap"
}

qq-enum-ftp-hydra() {
    __check-project
    qq-vars-set-rhost
    __check-user
    print -z "hydra -l ${__USER} -P ${__PASSLIST} -e -o $(__hostpath)/ftp-hydra-brute.txt ${__RHOST} FTP"
}

qq-enum-ftp-lftp-grep() {
    qq-vars-set-rhost
    local q && __askvar q QUERY
    print -z "lftp ${__RHOST}:/ > find | grep -i \"${QUERY}\" "
}

qq-enum-ftp-wget-mirror() {
    __warn "The destination site will be mirrored in the current directory"
    qq-vars-set-rhost
    local u && __prefill u USER "anonymous"
    local p && __prefill p PASSWORD "anonymous@example.com"
    print -z "wget --mirror ftp://${u}:${p}@${__RHOST}"
}
