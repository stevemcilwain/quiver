#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-ssl
#############################################################

qq-enum-web-ssl-tcpdump() {
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 443 -w $(__hostpath)/ssl.pcap"
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
    qq-vars-set-url
    print -z "openssl s_client -showcerts -connect ${__URL}:443" 
}
