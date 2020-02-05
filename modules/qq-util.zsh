#!/usr/bin/env zsh

############################################################# 
# qq-util
#############################################################

alias qq-util-sort-to-csv="paste -s -d, -"

qq-util-sort-file() cat $1 | sort -u -o $1

qq-util-sort-ips() cat $1 | sort -u | sort -V -o $1

qq-util-system-mount() print -z "sudo mount | column -t"

qq-util-network-public-ip() curl icanhazip.com

qq-util-network-listeners-watch() print -z "sudo watch -n 0.3 'netstat -pantlu | grep \"ESTABLISHED\|LISTEN\"'"

qq-util-network-listeners-ss() print -z "sudo ss -plunt"

qq-util-system-memory-top10() print -z "ps aux | sort -rk 4,4 | head -n 10 | awk '{print \$4,\$11}'"

qq-util-network-lsof() print -z "sudo lsof -P -i -n"