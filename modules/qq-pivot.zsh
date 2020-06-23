#!/usr/bin/env zsh

############################################################# 
# qq-pivot
#############################################################

qq-pivot-help() {
    cat << "DOC"

qq-pivot
------------
The pivot namespace provides commands for using ssh to proxy and pivot.

Commands
--------
qq-pivot-install:                      installs dependencies
qq-pivot-mount-remote-sshfs:           mounts a remote directory to local /mnt path using sshfs
qq-pivot-ssh-dynamic-proxy:            uses remote as a dynamic proxy
qq-pivot-ssh-remote-to-local:          forwards remote port to local port
qq-pivot-ssh-remote-to-local-burp:     forwards remote port 8080 to local port 8080

DOC
}

qq-pivot-install() {
    __info "Running $0..."
    __pkgs sshfs rsync
}

qq-pivot-mount-remote-sshfs() { 
    __check-user
    local lm && __askpath lm LMOUNT /mnt
    local rm && __askvar rm RMOUNT /
    qq-vars-set-rhost
    mkdir -p ${lm}
    print -z "sshfs ${__USER}@${__RHOST}:${rm} ${lm}" 
}

qq-pivot-ssh-dynamic-proxy() {
    __check-user
    qq-vars-set-rhost
    qq-vars-set-lport
    print -z "ssh -D ${__LPORT} -CqN ${__USER}@${__RHOST}" 
}

qq-pivot-ssh-remote-to-local() {
    __check-user
    qq-vars-set-rhost
    qq-vars-set-rport
    qq-vars-set-lport
    print -z "ssh -R ${__LPORT}:127.0.0.1:${__RPORT} ${__USER}@${__RHOST}" 
}

qq-pivot-ssh-remote-to-local-burp() {
    __check-user
    qq-vars-set-rhost
    print -z "ssh -R 8080:127.0.0.1:8080 ${__USER}@${__RHOST}"
}

