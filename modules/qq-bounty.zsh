#!/usr/bin/env zsh

############################################################# 
# qq-bounty
#############################################################

qq-bounty-scope() {
  qq-vars-set-output
  local word && read "word?$fg[cyan]WORD:$reset_color "
  print -z "echo \"^.*?${word}\..*\$ \" >> ${__OUTPUT}/burp/scope.txt"
}

qq-bounty-rescope() {
  qq-vars-set-output
  local url && read "url?$fg[cyan]URL:$reset_color "
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
