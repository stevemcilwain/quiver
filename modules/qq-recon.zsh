#!/usr/bin/env zsh

############################################################# 
# qq-recon
#############################################################

qq-recon-script-webrecon() {
  local f && read "f?File: "
  __warn "Uses your current directory for output"
  print -z "${__SCRIPTS}/webrecon.sh ${f}"
}

qq-recon-asns-by-org-browser() {
  __info "Save IP networks in cidr.txt"
  __info "https://bgp.he.net/"
}

qq-recon-asns-by-org-amass() {
  local o && read "o?Org: "
  print -z "amass intel -org ${o} | cut -d, -f1"
}

qq-recon-cidr-by-asn-hackertarget() {
  local a && read "a?ASN: "
  print -z "curl https://api.hackertarget.com/aslookup/\?q\=AS$a && echo"
}

qq-recon-cidr-by-asn-bgpview() {
  local a && read "a?ASN: "
  print -z "curl -s https://api.bgpview.io/asn/$a/prefixes | jq -r '.data | .ipv4_prefixes, .ipv6_prefixes | .[].prefix'"
}

qq-recon-domains-by-whois-amass() {
  local d && read "d?Domain: "
  print -z "amass intel -active -whois -d ${d}"
}

qq-recon-domains-by-asn-amass() {
  local a && read "a?ASN: "
  print -z "amass intel -active -asn ${a}"
}

qq-recon-subs-by-domain-amass() {
  local d && read "d?Domain: "
  print -z "amass enum -d ${d}"
}

qq-recon-domains-by-crt.sh() {
  local s && read "s?Search (domain, url, etc): "
  print -z "${__SCRIPTS}/crt.sh ${s}"
}

qq-recon-subs-by-domain-crt.sh() {
  local d && read "d?Domain: "
  print -z "curl 'https://crt.sh/?q=%.${d}' | grep -i "${d}" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v " " | sort -u"
}

qq-recon-subs-by-domain-subfinder() {
  local d && read "d?Domain: "
  print -z "subfinder -d ${d} -nW -silent >> domains.txt"
}

qq-recon-subs-by-domain-sublist3r() {
  local d && read "d?Domain: "
  print -z "python3 sublist3r.py -d ${d} -b -p 80,443,8080,4443 -t 10 -e Baido,Yahoo,Google,Bing,Ask,Netcraft,VirusTotal,SSL,ThreatCrowd,PassiveDNS"
}

qq-recon-subs-by-domain-dnsrecon() {
  local d && read "domain?Domain: "
  print -z "dnsrecon -d ${d}"
}

qq-recon-files-metagoofil() {
  local d && read "d?Domain: "
  local ft && read "ft?File type: "
  print -z "metagoofil -d ${d} -t ${ft} -o files"
}

qq-recon-wordlist-by-website-cewl() {
  __check-UA
  local u && read "u?Url: "
  print -z "cewl -a -d 3 -m 5 -u \"${__UA}\" -w tmp.list ${u} && \
    john --wordlist=tmp.list --rules --stdout"
}

qq-recon-email-by-domain-theharvester() {
  local d && read "d?Domain: "
  print -z "theharvester -d ${d} -l 50 -b all -n -t -e 1.1.1.1"
}

qq-recon-domains-by-brute-ffuf() {
  local d && read "domain?Domain: "
  print -z "ffuf -u FUZZ.${d} -w ${__WORDS_ALL} -v | grep \"| URL | \" | awk '{print \$4}'"
}

qq-recon-github-by-user-curl() {
  local u && read "u:User: "
  print -z "curl -s \"https://api.github.com/users/${u}/repos?per_page=1000\" | jq '.[].git_url'"
}

