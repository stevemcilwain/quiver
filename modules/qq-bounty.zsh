#!/usr/bin/env zsh

############################################################# 
# qq-bounty
#############################################################

qq-bounty-scope() {
  qq-vars-set-output
  local word 
  [[ -z $1 ]] && word=$1 || read "word?WORD: "
  print -z "echo \"^.*?${word}\..*\$ \" >> ${__OUTPUT}/burp/scope.txt"
}

qq-bounty-rescope() {
  qq-vars-set-output
  local url
  [[ -z $1 ]] && url=$1 || read "url?URL(bounty): "
  print -z "rescope --burp -u ${url} -o ${__OUTPUT}/burp/scope.json"
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
