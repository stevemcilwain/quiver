#!/usr/bin/env zsh

############################################################# 
# qq-pivot
#############################################################

qq-pivot-mount-remote-sshfs() { 
    local lm=$(rlwrap -S 'LMOUNT: ' -e '' -c -o cat)
    local rm && read "rm?RMOUNT: "
    local u && read "u?USER: "
    local r && read "r?RHOST: "
    print -z "sshfs ${u}@${r}:/${rm} /mnt/${lm}" 
}
alias qpmnt="qq-pivot-mount-remote-to-local-sshfs"

qq-pivot-ssh-dynamic-proxy() {
    local u && read "u?USER: "
    local r && read "r?RHOST: "
    local lp && read "lp?LPORT: "
    print -z "ssh -D ${lp} -CqN ${u}@${r}" 
}
alias qpd="qq-pivot-ssh-dynamic-proxy"

qq-pivot-ssh-remote-to-local() {
    local u && read "u?USER: "
    local r && read "r?RHOST: "
    local rp && read "rp?RPORT: "
    local lp && read "lp?LPORT: "
    print -z "ssh -R ${lp}:127.0.0.1:${rp} ${u}@${r}" 
}
alias qpr2l="qq-pivot-ssh-remote-to-local"

qq-pivot-ssh-remote-to-local-burp() {
    local u && read "u?USER: "
    local r && read "r?RHOST: "
    print -z "ssh -R 8080:127.0.0.1:8080 ${u}@${r}"
}
alias qpr2lb="qq-pivot-ssh-remote-to-local-burp"
