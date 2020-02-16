#!/usr/bin/env zsh

############################################################# 
# qq-recon-cidr
#############################################################

qq-recon-cidr-by-asn-hackertarget() {
  local a && read "a?ASN: "
  print -z "curl https://api.hackertarget.com/aslookup/\?q\=AS$a && echo"
}

qq-recon-cidr-by-asn-bgpview() {
  local a && read "a?ASN: "
  print -z "curl -s https://api.bgpview.io/asn/$a/prefixes | jq -r '.data | .ipv4_prefixes, .ipv6_prefixes | .[].prefix'"
}

qq-recon-cidr-lookup-ptr() {
    local d && read "d?Domain: "
    local p & read "p?Path to cidr.txt: "
    print -z "for c in $(cat ${p}); do f=$(echo \$c | cut -d/ -f1) && dnsrecon -d ${d} -r \$c -n 1.1.1.1 -c $(pwd)/ptr.\$f.csv; done"
}
