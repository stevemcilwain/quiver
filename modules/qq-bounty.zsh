#!/usr/bin/env zsh

############################################################# 
# qq-bounty
#############################################################

qq-bounty-scope-by-domain() {
  local d && read "d?DOMAIN(root): "
  print -z "^.*?${d}\..*\$"
}

qq-bounty-scope-by-url() {
    local u && read "u?URL: "
    print -z "rescope --burp -u ${u} -o burp.json"
}