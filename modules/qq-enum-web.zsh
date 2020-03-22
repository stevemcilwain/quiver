#!/usr/bin/env zsh

############################################################# 
# qq-enum-web
#############################################################

qq-enum-web-sweep-nmap() {
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -p80,443,8080 ${__NETWORK} -oA $(__netpath)/web-sweep"
}

qq-enum-web-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 80 -w $(__hostpath)/web.pcap"
}

qq-enum-web-whatweb() {
  local s && read "s?$fg[cyan]SEARCH(url,host,ip range):$reset_color "
  print -z "whatweb ${s} -a 3"
}

qq-enum-web-waf() {
  qq-vars-set-url
  print -z "wafw00f ${__URL} "
}

# vhosts

qq-enum-web-vhosts-gobuster() {
  qq-vars-set-url
  print -z "gobuster vhost -u ${__URL} -w /usr/share/seclists/Discovery/DNS/subdomains-top1mil-20000.txt -a \"${__UA}\" -t1"
}

# screens

qq-enum-web-screens-eyewitness() {
  local f=$(rlwrap -S "$fg[cyan]FILE(URLs):$reset_color " -e '' -c -o cat)
  local d=$(rlwrap -S "$fg[cyan]DIR(output):$reset_color " -e '' -c -o cat)
  print -z "eyewitness --web -f ${f} -d ${d} --user-agent \"${__UA}\" "
}

# apps

qq-enum-web-app-wordpress() {
  qq-vars-set-url
  print -z "wpscan --url ${__URL} --enumerate tt,vt,u,vp"
}

# elastic search

qq-enum-web-app-elastic-health() {
  local u && read "u?$fg[cyan]URL(:9200):$reset_color "
  print -z "curl -XGET ${u}:9200/_cluster/health?pretty"
}

qq-enum-web-app-elastic-indices() {
  local u && read "u?$fg[cyan]URL(:9200):$reset_color "
  print -z "curl -XGET ${u}:9200/_cat/indices?v"
}

qq-enum-web-app-elastic-search() {
  local u && read "u?$fg[cyan]URL(:9200):$reset_color "
  local index && read "index?$fg[cyan]INDEX:$reset_color "
  __info "example query: *:password"
  local query && read "query?$fg[cyan]QUERY:$reset_color "
  print -z "curl -XGET ${u}:9200/${index}/_search?q=${query}&size=10&pretty"
}

qq-enum-web-app-elastic-all() {
  local u && read "u?$fg[cyan]URL(:9200):$reset_color "
  local index && read "index?$fg[cyan]INDEX:$reset_color "
  print -z "curl -XGET ${u}:9200/${index}/_search?size=1000 > documents.json"
}

