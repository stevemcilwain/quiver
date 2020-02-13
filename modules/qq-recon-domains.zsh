#!/usr/bin/env zsh

############################################################# 
# qq-recon-domains
#############################################################

qq-recon-domains-by-whois-amass() {
  local d && read "d?Domain: "
  print -z "amass intel -active -whois -d ${d}"
}

qq-recon-domains-by-asn-amass() {
  local a && read "a?ASN: "
  print -z "amass intel -active -asn ${a}"
}

qq-recon-domains-by-crt.sh() {
  local s && read "s?Search (domain, url, etc): "
  print -z "${__SCRIPTS}/crt.sh ${s}"
}

qq-recon-domains-by-brute-ffuf() {
  local d && read "domain?Domain: "
  print -z "ffuf -u FUZZ.${d} -w ${__WORDS_ALL} -v | grep \"| URL | \" | awk '{print \$4}'"
}
