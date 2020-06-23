#!/usr/bin/env zsh

############################################################# 
# qq-shell-handlers
#############################################################

qq-shell-handlers-help() {
    cat << "DOC"

qq-shell-handlers
-----------------
The shell-handlers namespace provides commands for spawning reverse shell
connections.

Commands
--------
qq-shell-handlers-install:        installs dependencies
qq-shell-handlers-msf-ssl-gen:    impersonate a real SSL certificate for use in reverse shells
qq-shell-handlers-nc:             
qq-shell-handlers-ncrl:           
qq-shell-handlers-nc-udp:
qq-shell-handlers-socat:

DOC
}

qq-shell-handlers-install() {
    __info "Running $0..."
    __pkgs netcat socat
}

# netcat

qq-shell-handlers-nc() {
    qq-vars-set-lport
    print -z "nc -nlvp ${__LPORT}"
}

qq-shell-handlers-ncrl() {
    qq-vars-set-lport
    print -z "rlwrap nc -nlvp ${__LPORT}"
}

qq-shell-handlers-nc-udp() {
    qq-vars-set-lport
    print -z "nc -nlvu ${__LPORT}"
}

# socat

qq-shell-handlers-socat() {
    qq-vars-set-lport
    print -z "socat file:`tty`,raw,echo=0 tcp-listen:${__LPORT}"
}
