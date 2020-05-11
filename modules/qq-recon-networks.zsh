#!/usr/bin/env zsh

############################################################# 
# qq-recon-networks
#############################################################

qq-recon-networks-help() {
  cat << END

qq-recon-networks
-------------
The recon-networks namespace provides commands to recon ASNs and IP networks for an organization.
All network data is stored in $__PROJECT/networks.

Commands
--------
qq-recon-networks-install: installs dependencies
qq-recon-networks-amass-asn: find asns by domain
qq-recon-networks-bgp: use the bgp.he.net website to find asns and networks
qq-recon-networks-bgpview-ipv4: curl api.bgpview.io for ipv4 networks by asn
qq-recon-networks-bgpview-ipv6: curl api.bgpview.io for ipv6 networks by asn

END
}

qq-recon-networks-install() {
  __pkgs curl jq amass
}

qq-recon-networks-bgp() {
  __info "Search https://bgp.he.net/"
}

qq-recon-networks-amass-asns() {
  __check-project
  local o && read "o?$(__cyan ORG: )"
  mkdir ${__PROJECT}/networks
  print -z "amass intel -org ${o} | cut -d, -f1 >> ${__PROJECT}/networks/asns.txt "
}

qq-recon-networks-bgpview-ipv4() {
  __check-project
  local a && read "a?$(__cyan ASN: )"
  mkdir ${__PROJECT}/networks
  print -z "curl -s https://api.bgpview.io/asn/$a/prefixes | jq -r '.data | .ipv4_prefixes | .[].prefix' >> ${__PROJECT}/networks/ipv4.txt"
}

qq-recon-networks-bgpview-ipv6() {
  __check-project
  local a && read "a?$(__cyan ASN: )"
  mkdir ${__PROJECT}/networks
  print -z "curl -s https://api.bgpview.io/asn/$a/prefixes | jq -r '.data | .ipv6_prefixes | .[].prefix'  >> ${__PROJECT}/networks/ipv6.txt"
}

