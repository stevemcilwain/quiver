#!/usr/bin/env zsh

############################################################# 
# qq-recon-subs
#############################################################

qq-recon-subs-help() {
  cat << END

qq-recon-subs
-------------
The recon namespace provides commands to recon vertical sub-domains of a root domain.
All subdomains for a domain will be stored in $__PROJECT/amass and $__PROJECT/domains/$DOMAIN/subs.txt.
You can sort unique this file in place with the "sfu" alias.

Commands
--------
qq-recon-subs-install: installs dependencies

Commands - enumeration
----------------------
qq-recon-subs-amass-enum: enumerate subdomains into amass db (api keys help)
qq-recon-subs-amass-diff: track changes between last 2 enumerations using amass db
qq-recon-subs-amass-names: list gathered subs in the amass db
qq-recon-subs-crt.sh: gather subdomains from crt.sh
qq-recon-subs-subfinder: gather subdomains from sources (api keys help)
qq-recon-subs-assetfinder: gather subdomains from sources (api keys help)
qq-recon-subs-wayback: gather subdomains from Wayback Machine

Commands - brute force
----------------------
qq-recon-subs-brute-gobuster: brute force subdomains using gobuster and a wordlist
qq-recon-subs-brute-dnsrecon: brute force subdomains using dnsrecon and a wordlist

Commands - processing
---------------------
qq-recon-subs-resolve-massdns: resolve a file of subdomains using massdns
qq-recon-subs-gen-wordlist: generate a wordlist of possible subs

END
}

qq-recon-subs-install() {

  __pkgs gobuster amass curl seclists dnsrecon

  qq-install-golang
  go get -u github.com/projectdiscovery/subfinder/cmd/subfinder
  go get -u github.com/tomnomnom/assetfinder
  go get -u github.com/tomnomnom/waybackurls

  qq-install-massdns
}

qq-recon-subs-amass-enum() {
  __check-project
  qq-vars-set-domain
  mkdir -p ${__PROJECT}/amass
  print -z "amass enum -active -ip -d ${__DOMAIN} -dir ${__PROJECT}/amass"
}

qq-recon-subs-amass-diff() {
  __check-project
  qq-vars-set-domain
  mkdir -p ${__PROJECT}/amass
  print -z "amass track -d ${__DOMAIN} -last 2 -dir ${__PROJECT}/amass"
}

qq-recon-subs-amass-names() {
  __check-project
  qq-vars-set-domain
  mkdir -p ${__PROJECT}/amass
  print -z "amass db -names -d ${__DOMAIN} -dir ${__PROJECT}/amass >> $(__dompath)/subs.txt"
}

qq-recon-subs-crt.sh() {
  __check-project
  qq-vars-set-domain
  print -z "curl -s 'https://crt.sh/?q=%.${__DOMAIN}' | grep -i \"${__DOMAIN}\" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v \" \" | sort -u >>  $(__dompath)/subs.txt "
}

qq-recon-subs-subfinder() {
  __check-project
  qq-vars-set-domain
  local t && read "t?$(__cyan THREADS: )"
  print -z "subfinder -t ${t} -d ${__DOMAIN} -nW -silent >> $(__dompath)/subs.txt"
}

qq-recon-subs-assetfinder() {
  __check-project
  qq-vars-set-domain
  print -z "echo ${__DOMAIN} | assetfinder --subs-only >> $(__dompath)/subs.txt" 
}

qq-recon-subs-wayback() {
  __check-project
  qq-vars-set-domain 
  print -z "echo ${__DOMAIN} | waybackurls | cut -d "/" -f3 | sort -u | grep -v \":80\" >> $(__dompath)/subs.txt"
}

qq-recon-subs-brute-gobuster() {
  __check-project
  qq-vars-set-domain
  local t && read "t?$(__cyan THREADS: )"
  print -z "gobuster dns -r 8.8.8.8 -t ${t} --wildcard -d ${__DOMAIN} -c -i -w /usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt >> $(__dompath)/subs.txt"
}

qq-recon-subs-brute-dnsrecon() {
  __check-project
  qq-vars-set-domain
  print -z "dnsrecon -d ${__DOMAIN} -t brt -D /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -c $(__dompath)/subs.csv "
}

qq-recon-subs-resolve-massdns() {
  __check-project
  print -z "massdns -r /opt/recon/massdns/lists/resolvers.txt -t A -o S -w ${__PROJECT}/domains/resolved.txt $(__dompath)/subs.txt"
}

qq-recon-subs-gen-wordlist() {
  __check-project
  qq-vars-set-domain
  local f=$(rlwrap -S "$(__cyan FILE: )" -e '' -P "/usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt" -c -o cat)
  print -z "for s in \$(cat ${f}); do echo \$s.${__DOMAIN} >> $(__dompath)/subs.wordlist.txt; done"
}
