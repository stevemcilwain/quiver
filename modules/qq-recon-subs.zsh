#!/usr/bin/env zsh

############################################################# 
# qq-recon-subs
#############################################################

qq-recon-subs-help() {
    cat << "DOC"

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
qq-recon-subs-amass-enum:       enumerate subdomains into amass db (api keys help)
qq-recon-subs-amass-diff:       track changes between last 2 enumerations using amass db
qq-recon-subs-amass-names:      list gathered subs in the amass db
qq-recon-subs-crt.sh:           gather subdomains from crt.sh
qq-recon-subs-subfinder:        gather subdomains from sources (api keys help)
qq-recon-subs-assetfinder:      gather subdomains from sources (api keys help)
qq-recon-subs-wayback:          gather subdomains from Wayback Machine

Commands - brute force
----------------------
qq-recon-subs-brute-massdns:    try to resolve a list of subdomains generated for brute forcing
qq-recon-subs-gen-wordlist:     generate a wordlist of possible sub domains 

Commands - processing
---------------------
qq-recon-subs-resolve-massdns:   resolve a file of subdomains using massdns
qq-recon-subs-resolve-parse:     parse resolved.txt into A, CNAME and IP's

DOC
}

qq-recon-subs-install() {
    __info "Running $0..."
    __pkgs gobuster amass curl wordlists seclists dnsrecon dnsutils

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
    print -z "amass db -names -d ${__DOMAIN} -dir ${__PROJECT}/amass | tee -a $(__dompath)/subs.txt"
}

qq-recon-subs-crt.sh() {
    __check-project
    qq-vars-set-domain
    print -z "curl -s 'https://crt.sh/?q=%.${__DOMAIN}' | grep -i \"${__DOMAIN}\" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v \" \" | sort -u | tee -a  $(__dompath)/subs.txt "
}

qq-recon-subs-subfinder() {
    __check-project
    qq-vars-set-domain
    __check-threads
    print -z "subfinder -t ${__THREADS} -d ${__DOMAIN} -nW -silent | tee -a $(__dompath)/subs.txt"
}

qq-recon-subs-assetfinder() {
    __check-project
    qq-vars-set-domain
    print -z "echo ${__DOMAIN} | assetfinder --subs-only | tee -a $(__dompath)/subs.txt" 
}

qq-recon-subs-wayback() {
    __check-project
    qq-vars-set-domain 
    print -z "echo ${__DOMAIN} | waybackurls | cut -d "/" -f3 | sort -u | grep -v \":80\" | tee -a $(__dompath)/subs.txt"
}

qq-recon-subs-resolve-massdns() {
    __check-project
    __check-resolvers
    qq-vars-set-domain
    print -z "massdns -r ${__RESOLVERS} -s 100 -c 3 -t A -o S -w  $(__dompath)/resolved.txt $(__dompath)/subs.txt"
}

qq-recon-subs-brute-massdns() {
    __check-project
    __check-resolvers
    qq-vars-set-domain
    __ask "Select the file containing a custom wordlist for ${__DOMAIN} (qq-recon-subs-gen-wordlist)"
    local f && __askpath f FILE $(__dompath)
    print -z "massdns -r ${__RESOLVERS} -s 100 -c 3 -t A -o S -w  $(__dompath)/resolved-brute.txt $f"
}

qq-recon-subs-resolve-parse() {
    __check-project
    qq-vars-set-domain
    __info "Generating files resolved-*.txt"
    grep -ie "CNAME" $(__dompath)/resolved.txt | sort -u > $(__dompath)/resolved-CNAME.txt
    grep -v "CNAME" $(__dompath)/resolved.txt | sort -u > $(__dompath)/resolved-A.txt
    grep -v "CNAME" $(__dompath)/resolved.txt | sort -u | cut -d' ' -f3 | sort -u > $(__dompath)/resolved-IP.txt
}

qq-recon-subs-gen-wordlist() {
    __check-project
    qq-vars-set-domain
    local f && __askpath f FILE /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt
    print -z "for s in \$(cat ${f}); do echo \$s.${__DOMAIN} >> $(__dompath)/subs.wordlist.txt; done"
}
