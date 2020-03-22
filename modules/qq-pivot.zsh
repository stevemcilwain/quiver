#!/usr/bin/env zsh

############################################################# 
# qq-pivot
#############################################################

qq-pivot-mount-remote-sshfs() { 
    local lm=$(rlwrap -S "$fg[cyan]LMOUNT:$reset_color " -e '' -c -o cat)
    local rm && read "rm?$fg[cyan]RMOUNT:$reset_color "
    local u && read "u?$fg[cyan]USER:$reset_color "
    local r && read "r?$fg[cyan]RHOST:$reset_color "
    print -z "sshfs ${u}@${r}:/${rm} /mnt/${lm}" 
}
alias qpmnt="qq-pivot-mount-remote-to-local-sshfs"

qq-pivot-ssh-dynamic-proxy() {
    local u && read "u?$fg[cyan]USER:$reset_color "
    local r && read "r?$fg[cyan]RHOST:$reset_color "
    local lp && read "lp?$fg[cyan]LPORT:$reset_color "
    print -z "ssh -D ${lp} -CqN ${u}@${r}" 
}
alias qpd="qq-pivot-ssh-dynamic-proxy"

qq-pivot-ssh-remote-to-local() {
    local u && read "u?$fg[cyan]USER:$reset_color "
    local r && read "r?$fg[cyan]RHOST:$reset_color "
    local rp && read "rp?$fg[cyan]RPORT:$reset_color "
    local lp && read "lp?$fg[cyan]LPORT:$reset_color "
    print -z "ssh -R ${lp}:127.0.0.1:${rp} ${u}@${r}" 
}
alias qpr2l="qq-pivot-ssh-remote-to-local"

qq-pivot-ssh-remote-to-local-burp() {
    local u && read "u?$fg[cyan]USER:$reset_color "
    local r && read "r?$fg[cyan]RHOST:$reset_color "
    print -z "ssh -R 8080:127.0.0.1:8080 ${u}@${r}"
}
alias qpr2lb="qq-pivot-ssh-remote-to-local-burp"
