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
    local f=$(rlwrap -S "$fg[cyan]FILE(cacert.der):$reset_color " -e '' -c -o cat)
    print -z "sudo openssl x509 -inform DER -in ${f} -out cacert.crt"
}
alias qder2crt="qq-enum-web-ssl-der-to-crt-openssl"


qq-enum-web-ssl-crt-ca-install() {
    local f=$(rlwrap -S "$fg[cyan]FILE(cacert.crt):$reset_color " -e '' -c -o cat)
    print -z "sudo cp ${f} /usr/local/share/ca-certificates/. && sudo update-ca-certificates"
}
alias qcrt2store="qq-enum-web-ssl-crt-ca-install"

qq-enum-web-ssl-certs() {
    qq-vars-set-url
    print -z "openssl s_client -showcerts -connect ${__URL}:443" 
}

qq-enum-ssl-cert-download() {
    qq-vars-set-url
	local d=$(echo "${__URL}" | cut -d/ -f3)
	print -z "openssl s_client -servername ${d} -connect ${d}:443 </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $(__urlpath)/ssl.certificate.`date +"%Y%m%d-%H%M%S"`.pem"
}

qq-enum-ssl-testssl-full() {
    qq-vars-set-url
	print -z "testssl --color=3 -oA $(__urlpath)/testssl.full.`date +"%Y%m%d-%H%M%S"` ${__URL} "
}
qq-enum-ssl-testssl-ciphers() {
    qq-vars-set-url
	print -z "testssl -E --color=3 -oA $(__urlpath)/testssl.ciphers.`date +"%Y%m%d-%H%M%S"` ${__URL} "
}
