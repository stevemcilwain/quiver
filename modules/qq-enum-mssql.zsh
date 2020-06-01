#!/usr/bin/env zsh

############################################################# 
# qq-enum-mssql
#############################################################

qq-enum-mssql-help() {
    cat << "DOC"

qq-enum-mssql
-------------
The qq-enum-mssql namespace contains commands for scanning and 
enumerating MS SQL Server services and databases.

Commands
--------
qq-enum-mssql-install:             installs dependencies
qq-enum-mssql-nmap-sweep:          scan a network for services
qq-enum-mssql-tcpdump:             capture traffic to and from a host
qq-enum-mssql-sqsh:                make an interactive database connection
qq-enum-mssql-impacket-client:     connect using impacket as a sql client
qq-enum-mssql-hydra:               brute force passwords for a user account

DOC
}

qq-enum-mssql-install() {
    __info "Running $0..."
    __pkgs tcpdump nmap sqsh impacket-scripts hydra
}

qq-enum-mssql-nmap-sweep() {
    __check-project
    qq-vars-set-network
    print -z "sudo nmap -n -Pn -sS -sU -p T:1433,U:1434 ${__NETWORK} -oA $(__netpath)/mssql-sweep"
}

qq-enum-mssql-tcpdump() {
    __check-project
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 1433 -w $(__hostpath)/mssql.pcap"
}

qq-enum-mssql-sqsh() {
    __check-project
    qq-vars-set-rhost
    __check-user
    print -z "sqsh -S ${__RHOST} -U ${__USER}"
}

qq-enum-mssql-impacket-client() {
    qq-vars-set-rhost
    __check-user
    local db && __askvar db DATABASE
    print -z "python3 ${__IMPACKET}/mssqlclient.py ${__USER}@${__RHOST} -db ${db} -windows-auth "
}

qq-enum-mssql-hydra() {
    __check-project
    qq-vars-set-rhost
    __check-user
    print -z "hydra -l ${__USER} -P ${__PASSLIST} -e -o $(__hostpath)/mssql-hydra-brute.txt ${__RHOST} MS-SQL"
}