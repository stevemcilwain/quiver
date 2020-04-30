#!/usr/bin/env zsh

############################################################# 
# qq-recon-asns
#############################################################

qq-recon-asns-by-org-browser() {
  __info "Save IP networks in cidr.txt"
  __info "https://bgp.he.net/"
}

qq-recon-asns-by-org-amass() {
  local o && read "o?$fg[cyan]ORG:$reset_color "
  print -z "amass intel -org ${o} | cut -d, -f1"
}
