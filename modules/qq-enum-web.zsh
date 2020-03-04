#!/usr/bin/env zsh

############################################################# 
# qq-enum-web
#############################################################

qq-enum-web-sweep-nmap() {
  local s && read "s?SUBNET: "
  print -z "sudo nmap -n -Pn -sS -p80,443,8080 --open -oA web_sweep ${s} &&  grep open web_sweep.gnmap |cut -d' ' -f2 >> web_hosts.txt"
}

qq-enum-web-tcpdump() {
  __info "Interfaces: ${__IFACES}"
  local i && read "i?IFACE: "
  local r && read "r?RHOST: "
  print -z "sudo tcpdump -i ${i} host ${r} and tcp port 80 -w capture.${r}.pcap"
}

qq-enum-web-whatweb() {
  local s && read "s?SEARCH(url,host,ip range): "
  print -z "whatweb ${s} -a 3"
}

qq-enum-web-waf() {
  local u && read "u?URL: "
  print -z "wafw00f ${u} "
}

# vhosts

qq-enum-web-vhosts-gobuster() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "gobuster vhost -u ${u} -w /usr/share/seclists/Discovery/DNS/subdomains-top1mil-20000.txt -a \"${__UA}\" -t20 -o vhosts.$d.txt"
}

# screens

qq-enum-web-screens-eyewitness() {
  local f=$(rlwrap -S 'FILE(URLs): ' -e '' -c -o cat)
  local d=$(rlwrap -S 'DIR(output): ' -e '' -c -o cat)
  print -z "eyewitness --web -f ${f} -d ${d} --user-agent \"${__UA}\" "
}

# apps

qq-enum-web-app-wordpress() {
  local u && read "u?URL: "
  local d=$(echo "${u}" | cut -d/ -f3)
  print -z "wpscan --url ${u} --enumerate tt,vt,u,vp > wp.${d}.txt"
}

# elastic search

qq-enum-web-app-elastic-health() {
  local u && read "u?URL(:9200): "
  print -z "curl -XGET ${u}:9200/_cluster/health?pretty"
}

qq-enum-web-app-elastic-indices() {
  local u && read "u?URL(:9200): "
  print -z "curl -XGET ${u}:9200/_cat/indices?v"
}

qq-enum-web-app-elastic-search() {
  local u && read "u?URL(:9200): "
  local index && read "index?INDEX: "
  __info "example query: *:password"
  local query && read "query?QUERY: "
  print -z "curl -XGET ${u}:9200/${index}/_search?q=${query}&size=10&pretty"
}

qq-enum-web-app-elastic-all() {
  local u && read "u?URL(:9200): "
  local index && read "index?INDEX: "
  print -z "curl -XGET ${u}:9200/${index}/_search?size=1000 > documents.json"
}

# Notes 

qq-enum-web-notes-api() {
  glow ${__NOTES}/enum-web-api.md
}

qq-enum-web-notes-drupal() {
  glow ${__NOTES}/enum-web-app-drupal-notes.md
}

qq-enum-web-notes-wordpress() {
  glow ${__NOTES}/enum-web-app-wordpress-notes.md
}

qq-enum-web-notes-traversal() {
  glow ${__NOTES}/enum-web-dir-traversal.md
}

qq-enum-web-notes-bypass-upload() {
  glow ${__NOTES}/enum-web-bypass-upload.md
}

qq-enum-web-notes-bypass-waf() {
  glow ${__NOTES}/enum-web-bypass-waf.md
}
