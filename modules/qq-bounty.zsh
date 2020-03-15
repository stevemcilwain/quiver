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

qq-bounty-sudoers-easy() {
  __warn "This is dangerous! Remove when done."
  print -z "echo \"$USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/nmap, /usr/bin/masscan, /usr/sbin/tcpdump\" | sudo tee /etc/sudoers.d/$USER"
}
alias easymode="qq-bounty-sudoers-easy"

qq-bounty-sudoers-harden() {
  print -z "sudo rm /etc/sudoers.d/$USER"
}
alias hardmode="qq-bounty-sudoers-harden"

# qq-bounty-sync-remote-to-local-sshfs() {

# }
