#!/usr/bin/env zsh
 
############################################################# 
# qq-enum-dns
#############################################################

qq-enum-dns-help() {
  cat << "DOC"

qq-enum-dns
-------------
The qq-enum-dns namespace contains commands for scanning and enumerating DNS records and servers.
Commands are executed against specific name servers (__RHOST) rather than public resolvers.

Commands
--------
qq-enum-dns-install:              installs dependencies
qq-enum-dns-nmap-sweep:           scan a network for services
qq-enum-dns-tcpdump:              capture traffic to and from a host
qq-enum-dns-host-txfr:            attempt a zone transfer
qq-enum-dns-host-all:             list all types
qq-enum-dns-host-txt:             list txt records
qq-enum-dns-host-mx:              list mx records
qq-enum-dns-host-ns:              list ns records
qq-enum-dns-host-srv:             list srv records
qq-enum-dns-nmap-ad:              discover Active Directory related records
qq-enum-dns-dnsrecon:             discover dns records, servers and attempt zone txfrs
qq-enum-dns-dnsrecon-reverse:     do reverse lookups on an IP network

DOC
}

qq-enum-dns-install() {

  __pkgs tcpdump nmap dnsutils dnsrecon 

}

qq-enum-dns-nmap-sweep() {
  __check-project
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -sU -p53 ${__NETWORK} -oA $(__netpath)/dns-sweep"
}

qq-enum-dns-tcpdump() {
  __check-project  
  __check-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 53 -w $(__hostpath)/dns.pcap"
}

qq-enum-dns-host-txfr() {
  qq-vars-set-rhost
  qq-vars-set-domain
  print -z "host -l ${__DOMAIN} ${__RHOST}"
}

qq-enum-dns-host-all() {
  qq-vars-set-domain
  qq-vars-set-rhost
  print -z "host -a ${__DOMAIN} ${__RHOST}"
}

qq-enum-dns-host-txt() {
  qq-vars-set-domain
  qq-vars-set-rhost
  print -z "host -t txt ${__DOMAIN} ${__RHOST}"
}

qq-enum-dns-host-mx() {
  qq-vars-set-domain
  qq-vars-set-rhost
  print -z "host -t mx ${__DOMAIN} ${__RHOST}"
}

qq-enum-dns-host-ns() {
  qq-vars-set-domain
  qq-vars-set-rhost
  print -z "host -t ns ${__DOMAIN} ${__RHOST}"
}

qq-enum-dns-host-srv() {
  qq-vars-set-domain
  qq-vars-set-rhost
  print -z "host -t srv ${__DOMAIN} ${__RHOST}"
}

qq-enum-dns-nmap-ad() {
  __check-project
  qq-vars-set-domain
  qq-vars-set-rhost
  print -z "nmap --script dns-srv-enum --script-args dns-srv-enum.domain=${__DOMAIN} ${__RHOST} -o $(__dompath)/nmap-AD.txt"
}

qq-enum-dns-dnsrecon() {
  __check-project
  qq-vars-set-domain
  qq-vars-set-rhost
  print -z "dnsrecon -d ${__DOMAIN} -n ${__RHOST} -a -s -w -z --threads 10 -c $(__dompath)/dns.csv"
}

qq-enum-dns-dnsrecon-reverse() {
  __check-project
  qq-vars-set-rhost
  mkdir -p ${__PROJECT}/domains
  print -z "dnsrecon -r ${__NETWORK} -n ${__RHOST} -c ${__PROJECT}/domains/revdns.csv"
}
