#!/usr/bin/env zsh

############################################################# 
# Web
#############################################################

qq-enum-web-sweep-nmap() {
  local s && read "s?Subnet (range): "
  print -z "nmap -n -Pn -sS -p80,443,8080 -oA web_sweep ${s} && \
  grep open web_sweep.gnmap |cut -d' ' -f2 > sweep.${s}.txt"
}

qq-enum-web-tcpdump() {
  local i && read "i?Interface: "
  local r && read "r?Remote Host: "
  print -z "tcpdump -i ${i} host ${r} and tcp port 80 -w capture.${r}.pcap"
}

qq-enum-web-whatweb() {
  local s && read "s?Search: "
  print -z "whatweb ${s} -a 3"
}

qq-enum-web-waf() {
  local u && read "u?Url: "
  print -z "wafw00f ${u} "
}

qq-enum-web-scope-burp() {
  print -z ".*\.domain\.com$"
}

# vhosts

qq-enum-web-vhosts-gobuster() {
  local u && read "u?Url: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "gobuster vhost -u ${u} -w /usr/share/seclists/Discovery/DNS/subdomains-top1mil-20000.txt \
  -a \"${__UA}\" -t20 -o vhosts.$d.txt"
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



# apps

qq-enum-web-app-wordpress() {
  local u && read "u?Url: "
   local d=$(echo "${u}" | cut -d/ -f3)
  print -z "wpscan --url ${u} --enumerate tt,vt,u,vp > wp.${d}.txt"
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


