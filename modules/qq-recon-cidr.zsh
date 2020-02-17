#!/usr/bin/env zsh

############################################################# 
# qq-recon-cidr
#############################################################

qq-recon-cidr-by-asn-bgpview() {
  local a && read "a?ASN: "
  print -z "curl -s https://api.bgpview.io/asn/$a/prefixes | jq -r '.data | .ipv4_prefixes, .ipv6_prefixes | .[].prefix'"
}

qq-recon-cidr-by-asns-file-bgpview() {
  local f=$(rlwrap -S 'FILE(DOMAINS): ' -e '' -c -o cat)
  print -z "for a in \$(cat ${f}); do curl -s https://api.bgpview.io/asn/\$a/prefixes | jq -r '.data | .ipv4_prefixes, .ipv6_prefixes | .[].prefix' >> cidr.txt; done"
}

qq-recon-cidr-lookup-ptr() {
  local d && read "d?DOMAIN: "
  local f=$(rlwrap -S 'FILE(CIDRs): ' -e '' -c -o cat)
  print -z "for c in \$(cat ${f}); do f=\$(echo \$c | cut -d/ -f1) && dnsrecon -d ${d} -r \$c -n 1.1.1.1 -c $(pwd)/ptr.\$f.csv; done"
}
