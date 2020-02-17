#!/usr/bin/env zsh

############################################################# 
# qq-recon-domains
#############################################################

qq-recon-domains-by-whois-amass() {
  local d && read "d?DOMAIN: "
  print -z "amass intel -active -whois -d ${d}"
}

qq-recon-domains-by-asn-amass() {
  local a && read "a?ASN: "
  print -z "amass intel -active -asn ${a}"
}

qq-recon-domains-by-asns-amass() {
  local f=$(rlwrap -S 'FILE(ASNs): ' -e '' -c -o cat)
  local asn_csv=$(cat ${f} | paste -s -d, - )
  print -z "amass intel -active -asn ${asn_csv}"
}

qq-recon-domains-by-crt.sh() {
  local s && read "s?SEARCH(domain, url, name): "
  print -z "${__SCRIPTS}/crt.sh ${s}"
}

qq-recon-domains-by-brute-ffuf() {
  local d && read "d?DOMAIN: "
  print -z "ffuf -u FUZZ.${d} -w ${__WORDS_ALL} -v | grep \"| URL | \" | awk '{print \$4}'"
}
