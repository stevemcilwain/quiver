#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-elastic
#############################################################

qq-enum-web-elastic-help() {
  cat << "DOC"

qq-enum-web-elastic
-------------------
The qq-enum-web-elastic namespace contains commands for scanning and enumerating
elastic search services.

Commands
--------
qq-enum-web-elastic-install:     installs dependencies
qq-enum-web-elastic-nmap:        scan the target using the elasticsearch nmap nse script
qq-enum-web-elastic-health:      query the target using curl for cluster health
qq-enum-web-elastic-indices:     query the target using curl for indices
qq-enum-web-elastic-search:      query an index using curl
qq-enum-web-elastic-all:         query for 1000 records in an index using curl

DOC
}

qq-enum-web-elastic-install() {
    __pkgs nmap curl
    qq-install-nmap-elasticsearch-nse
}

qq-enum-web-elastic-nmap() {
  __check-project
  qq-vars-set-rhost
  print -z "sudo nmap -n -Pn -p9200 --script=elasticsearch ${__RHOST} -oN $(__hostpath)/nmap-elastic.txt"
}

qq-enum-web-elastic-health() {
  qq-vars-set-url
  print -z "curl -A \"${__UA}\" -XGET \"${__URL}:9200/_cluster/health?pretty\""
}

qq-enum-web-elastic-indices() {
  qq-vars-set-url
  print -z "curl -A \"${__UA}\" -XGET \"${__URL}:9200/_cat/indices?v\""
}

qq-enum-web-elastic-search() {
  qq-vars-set-url
  local i && __askvar i "INDEX" 
   __ask "Enter a query, such as *:password"
  local q && __askvar q "QUERY"
  print -z "curl -A \"${__UA}\" -XGET \"${__URL}:9200/${i}/_search?q=${q}&size=10&pretty\""
}

qq-enum-web-elastic-all() {
  __check-project
  qq-vars-set-url
  local i && __askvar i "INDEX"
  print -z "curl -A \"${__UA}\" -XGET \"${__URL}:9200/${i}/_search?size=1000\" | tee $(__urlpath)/elastic-docs.json"
}
