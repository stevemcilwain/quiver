#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-ssl
#############################################################

qq-enum-web-ssl-tcpdump() {
    __info "Available: ${__IFACES}"
    local i && read "i?IFACE: "
    local r && read "r?RHOST: "
    print -z "tcpdump -i ${i} host ${r} and tcp port 443 -w capture.${r}.pcap"
}

qq-enum-web-ssl-der-to-crt-openssl() {
    local f=$(rlwrap -S 'FILE(cacert.der): ' -e '' -c -o cat)
    print -z "sudo openssl x509 -inform DER -in ${f} -out cacert.crt"
}
alias qder2crt="qq-enum-web-ssl-der-to-crt-openssl"


qq-enum-web-ssl-crt-ca-install() {
    local f=$(rlwrap -S 'FILE(cacert.crt): ' -e '' -c -o cat)
    print -z "sudo cp ${f} /usr/local/share/ca-certificates/. && sudo update-ca-certificates"
}
alias qcrt2store="qq-enum-web-ssl-crt-ca-install"

qq-enum-web-ssl-certs() {
    local u && read "u?URL: "
    print -z "openssl s_client -showcerts -connect ${u}:443" 
}
