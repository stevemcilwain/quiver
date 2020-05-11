#!/usr/bin/env zsh

############################################################# 
# qq-pivot
#############################################################

qq-pivot-help() {
  cat << END

qq-pivot
------------
The pivot namespace provides commands for using ssh to proxy and pivot.

Commands
--------
qq-pivot-install: installs dependencies
qq-pivot-mount-remote-sshfs: mounts a remote directory to local /mnt path using sshfs
qq-pivot-ssh-dynamic-proxy: uses remote as a dynamic proxy
qq-pivot-ssh-remote-to-local: forwards remote port to local port
qq-pivot-ssh-remote-to-local-burp: forwards remote port 8080 to local port 8080

END
}

qq-pivot-install() {

    __pkgs sshfs

}

qq-pivot-mount-remote-sshfs() { 
    local lm=$(rlwrap -S "$(__cyan LMOUNT: )" -e '' -c -o cat)
    local rm && read "rm?$(__cyan RMOUNT: )"
    local u && read "u?$(__cyan USER: )"
    qq-vars-set-rhost
    print -z "sshfs ${u}@${__RHOST}:/${rm} /mnt/${lm}" 
}

qq-pivot-ssh-dynamic-proxy() {
    local u && read "u?$(__cyan USER: )"
    qq-vars-set-rhost
    qq-vars-set-lport
    print -z "ssh -D ${__LPORT} -CqN ${u}@${__RHOST}" 
}

qq-pivot-ssh-remote-to-local() {
    local u && read "u?$(__cyan USER: )"
    qq-vars-set-rhost
    qq-vars-set-rport
    qq-vars-set-lport
    print -z "ssh -R ${__LPORT}:127.0.0.1:${__RPORT} ${u}@${__RHOST}" 
}

qq-pivot-ssh-remote-to-local-burp() {
    local u && read "u?$(__cyan USER: )"
    local r && read "r?$(__cyan RHOST: )"
    print -z "ssh -R 8080:127.0.0.1:8080 ${u}@${__RHOST}"
}

