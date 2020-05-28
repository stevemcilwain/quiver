#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-ssl
#############################################################

qq-enum-web-ssl-help() {
  cat << "DOC"

qq-enum-web-ssl
----------------
The enum-web-ssl namespace contains commands for enumerating SSL/TLS.

Commands
--------
qq-enum-web-ssl-install:              installs dependencies
qq-enum-web-ssl-tcpdump:              capture traffic to and from target
qq-enum-web-ssl-der-to-crt:           convert a .der file to .crt
qq-enum-web-ssl-crt-ca-install:       install a root certificate (.crt)
qq-enum-web-ssl-certs:                display cert from a url
qq-enum-web-ssl-cert-download:        download certs from a url
qq-enum-web-ssl-testssl-full:
qq-enum-web-ssl-testssl-ciphers:

DOC
}

qq-enum-web-ssl-install() {

  __pkgs curl nmap tcpdump openssl testssl
  
}

qq-enum-web-ssl-tcpdump() {
    __check-project
    qq-vars-set-iface
    qq-vars-set-rhost
    print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 443 -w $(__hostpath)/ssl.pcap"
}

qq-enum-web-ssl-der-to-crt() {
    __ask "Select the cacert.der file"
    local f && __askpath f FILE $(pwd)
    print -z "sudo openssl x509 -inform DER -in ${f} -out cacert.crt"
}

qq-enum-web-ssl-crt-ca-install() {
    __ask "Select the cacert.crt file"
    local f && __askpath f FILE $(pwd)
    print -z "sudo cp ${f} /usr/local/share/ca-certificates/. && sudo update-ca-certificates"
}

qq-enum-web-ssl-certs() {
    qq-vars-set-url
    print -z "openssl s_client -showcerts -connect ${__URL}:443" 
}

qq-enum-web-ssl-cert-download() {
    __check-project
    qq-vars-set-url
	local d=$(echo "${__URL}" | cut -d/ -f3)
	print -z "openssl s_client -servername ${d} -connect ${d}:443 </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-DOC CERTIFICATE-/p' > $(__urlpath)/ssl.certificate.`date +"%Y%m%d-%H%M%S"`.pem"
}

qq-enum-web-ssl-testssl-full() {
    __check-project
    qq-vars-set-url
	print -z "testssl --color=3 -oA $(__urlpath)/testssl.full.`date +"%Y%m%d-%H%M%S"` ${__URL} "
}

qq-enum-web-ssl-testssl-ciphers() {
    __check-project
    qq-vars-set-url
	print -z "testssl -E --color=3 -oA $(__urlpath)/testssl.ciphers.`date +"%Y%m%d-%H%M%S"` ${__URL} "
}
