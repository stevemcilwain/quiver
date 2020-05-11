#!/usr/bin/env zsh

############################################################# 
# qq-bounty
#############################################################

qq-bounty-help() {
  cat << END

qq-bounty
----------
The bounty namespace provides commands for generating scope files
and other system settings.

Commands
--------
qq-bounty-install: installs dependencies
qq-bounty-scope: generate a scope regex by root word (matches all to the left and right)
qq-bounty-rescope: uses rescope to generate burp scope from a url
qq-bounty-sudoers-easy: removes the requirment for sudo for common commands like nmap
qq-bounty-sudoers-harden: removes sudo exclusions

END
}

qq-bounty-install() {
  qq-install-golang
  go get -u github.com/root4loot/rescope
}

qq-bounty-scope() {
  qq-vars-set-project
  local word && read "word?$fg[cyan]WORD:$reset_color "
  print -z "echo \"^.*?${word}\..*\$ \" >> ${__PROJECT}/burp/scope.txt"
}

qq-bounty-rescope() {
  qq-vars-set-project
  local url && read "url?$fg[cyan]URL:$reset_color "
  print -z "rescope --burp -u ${url} -o ${__PROJECT}/burp/scope.json"
}

qq-bounty-sudoers-easy() {
  __warn "This is dangerous! Remove when done."
  print -z "echo \"$USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/nmap, /usr/bin/masscan, /usr/sbin/tcpdump\" | sudo tee /etc/sudoers.d/$USER"
}
alias easymode="qq-bounty-sudoers-easy"

qq-bounty-sudoers-harden() {
  print -z "sudo rm /etc/sudoers.d/$USER"
}
alias hardmode="qq-bounty-sudoers-harden"
