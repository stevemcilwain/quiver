#!/usr/bin/env zsh

############################################################# 
# qq-bounty
#############################################################

qq-bounty-help() {
  cat << "DOC"

qq-bounty
----------
The bounty namespace provides commands for generating scope files
and other system settings.

Commands
--------
qq-bounty-install:             installs dependencies
qq-bounty-scope:               generate a scope regex by root word (matches all to the left and right)
qq-bounty-rescope-txt:         uses rescope to generate scope from a url
qq-bounty-rescope-burp:        uses rescope to generate burp scope (JSON) from a url
qq-bounty-sudoers-easy:        removes the requirment for sudo for common commands like nmap
qq-bounty-sudoers-harden:      removes sudo exclusions
qq-bounty-sync-remote-to-local:      sync data from a remote server directory to a local directory using SSHFS
qq-bounty-sync-local-file-to-remote: sync a local file to a remote server using rsync over SSH
qq-bounty-google-domain-dyn:   update IP address using Google domains hosted dynamic record

DOC
}

qq-bounty-install() {
  __pkgs fusermount sshfs rsync curl
  qq-install-golang
  go get -u github.com/root4loot/rescope
}

qq-bounty-scope() {
  __check-project
  __check-org
  print -z "echo \"^.*?${__ORG}\..*\$ \" >> ${__PROJECT}/scope.txt"
}

qq-bounty-rescope-burp() {
  __check-project
  __ask "Enter the URL to the bug bounty scope description"
  qq-vars-set-url
  mkdir -p ${__PROJECT}/burp
  print -z "rescope --burp -u ${__URL} -o ${__PROJECT}/burp/scope.json"
}

qq-bounty-rescope-txt() {
  __check-project
  __ask "Enter the URL to the bug bounty scope description"
  qq-vars-set-url
  print -z "rescope --raw -u ${url} -o ${__PROJECT}/scope.txt"
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

qq-bounty-sync-remote-to-local() {
  __warn "Enter your SSH connection username@remote_host"
  local ssh && __askvar ssh SSH
  __warn "Enter the full remote path to the directory your want to copy from"
  local rdir && __askvar rdir "REMOTE DIR"
  __warn "Enter the full local path to the directory to use as a mount point"
  local mnt && __askpath mnt "LOCAL MOUNT" /mnt
  __warn "Enter the full local path to the directory to sync the data to"
  local ldir && __askpath lidr "LOCAL DIR" $HOME

  sudo mkdir -p $mnt
  
  __ok "Mounting $rdir to $mnt ..."
  sudo sshfs ${ssh}:${rdir} ${mnt}

  __ok "Syncing data from $mnt to $ldir ..."
  sudo rsync -avuc ${mnt} ${ldir}

  __ok "Unmounting $mnt. ..."
  sudo fusermount -u ${mnt}

  __ok "Sync Completed"
}

qq-bounty-sync-local-file-to-remote() {
  __warn "Enter your SSH connection username@remote_host"
  local ssh && __askvar ssh SSH
  __warn "Enter the full local path to the file you want to copy to your remote server"
  local lfile && __askpath lfile "LOCAL FILE" $HOME
  __warn "Enter the full remote path to the directory your want to copy the file to"
  local rdir && __askvar rdir "REMOTE DIR"
  print -z "rsync -avz -e \"ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null\" --progress $lfile $ssh:$rdir"
}

qq-bounty-google-domain-dyn() {
  local u && __askvar u USERNAME
  local p && __askvar p PASSWORD
  local d && __askvar d DOMAIN
  qq-vars-set-lhost 
  print -z "curl -s -a \"${__UA}\" https://$u:$p@domains.google.com/nic/update?hostname=${d}&myip=${__LHOST} "
}