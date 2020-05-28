#!/usr/bin/env zsh

############################################################# 
# qq-sys
#############################################################

qq-sys-help() {
  cat << "DOC"

qq-sys
----------
The qq-sys namespace provides commands that assist with managing Kali/Debian linux.

Commands
--------
qq-sys-pkgs-apt-upgrade:     update and full-upgrade with autoremove
qq-sys-pkgs-apt-query:       query if a package is installed or not  
qq-sys-pkgs-apt-fix:         fix broken packages
qq-sys-pkgs-go-update:       update go modules and packages with go get
qq-sys-fs-mounted:           show mounted file systems
qq-sys-fs-usage:             show file system usage totals
qq-sys-fs-last3:             show files modified in last 3 days in /etc
qq-sys-fs-large:             show files larger than 1GB in the root fs
qq-sys-mem-top10:            show top10 processes by memory usage
qq-sys-mem-free:             show overall memory usage
qq-sys-disk-top10:           show top 10 files by size in current directory
qq-sys-ps-tree:              show a process tree
qq-sys-ps-grep:              search list of processes
qq-sys-net-watch:            display network active connections
qq-sys-net-open4:            display open network connections ipv4
qq-sys-net-open6:            display open network connections ipv6
qq-sys-net-routes:           display the system routing table
qq-sys-net-ss:               display open network connections
qq-sys-net-lsof:             display open network connections
qq-sys-net-pubip:            query for the public IP
qq-sys-pvpn-update:          install or update proton vpn cli
qq-sys-pvpn-status:          check proton vpn status
qq-sys-pvpn-connect-tcp:     connect to proton vpn using tcp
qq-sys-pvpn-connect-udp:     connect to proton vpn using udp
qq-sys-pvpn-disconnect:      disconnect proton vpn
qq-sys-path-add:             add a new path to the PATH environment variable
qq-sys-file-replace:         replace an existing value in a file
qq-sys-file-dos-to-unix:     convert file with dos endings to unix
qq-sys-file-unix-to-dos:     convert file with unix endings to dos
qq-sys-file-sort-uniq:       sort a file uniq in place 
qq-sys-file-sort-uniq-ip:    sort a file of IP addresses uniq in place

DOC
}

qq-sys-pkgs-apt-upgrade() { print -z "sudo apt-get update && sudo apt-get full-upgrade && sudo apt-get autoremove" }

qq-sys-pkgs-apt-query() {
  local query && __askvar query PACKAGE 
  for pkg in "${query}"
  do
    dpkg -l | grep -qw $pkg && __ok "${pkg} is installed" || __warn "${pkg} not installed"
  done 
}

qq-sys-pkgs-apt-fix() { print -z "sudo apt-get install --fix-broken && sudo apt-get autoremove && sudo apt-get update" }

qq-sys-pkgs-go-update() { print -z "go get -u all" }

qq-sys-fs-mounted() { print -z "sudo mount | column -t" }

qq-sys-fs-usage() { print -z "df -mTh --total" }

qq-sys-fs-last3() { print -z "sudo find /etc -mtime -3" }

qq-sys-fs-large() { print -z "sudo find / -type f -size +1G" }

qq-sys-mem-top10() { print -z "sudo ps aux | sort -rk 4,4 | head -n 10 | awk '{print \$4,\$11}' " }

qq-sys-mem-free() { print -z "free -mt" }

qq-sys-disk-top10() { print -z "sudo du -sk ./* | sort -r -n | head -10" }

qq-sys-ps-tree() { print -z "ps auxf" }

qq-sys-ps-grep() { 
  local query && __askvar query QUERY 
  print -z "ps aux | grep -v grep | grep -i -e VSZ -e ${query}" 
}

qq-sys-net-watch() { print -z "sudo watch -n 0.3 'netstat -pantlu4 | grep \"ESTABLISHED\|LISTEN\"' " }

qq-sys-net-open4() { print z "sudo netstat -pantlu4"}

qq-sys-net-open6() { print z "sudo netstat -pantlu6"}

qq-sys-net-routes() { print -z "netstat -r --numeric-hosts" }

qq-sys-net-ss() { print -z "sudo ss -plaunt4" }

qq-sys-net-lsof() { print -z "sudo lsof -P -i -n "}

qq-sys-net-pubip() { print -z "curl -s \"https://icanhazip.com\" "}

qq-sys-pvpn-update() { print -z "sudo pip3 install protonvpn-cli --upgrade" }

qq-sys-pvpn-status() { print -z "sudo protonvpn status" }

qq-sys-pvpn-connect-tcp() { print -z "sudo protonvpn c -f" }

qq-sys-pvpn-connect-udp() { print -z "sudo protonvpn c -f -p udp" }

qq-sys-pvpn-disconnect() { print -z "sudo protonvpn disconnect" }

qq-sys-path-add() { 
  __ask "Enter new path to append to current PATH"
  local p && __askpath p PATH /   
  print -z "echo \"export PATH=\$PATH:${p}\" | tee -a $HOME/.zshrc" 
}

qq-sys-file-replace() {
  local replace && __askvar replace REPLACE
  local with && __askvar with WITH
  local file && __askpath file FILE $(pwd)
  print -z "sed 's/${replace}/${with}/g' ${file}"
} 

qq-sys-file-dos-to-unix() { 
  local file && __askpath file FILE $(pwd)
  print -z "tr -d \"\015\" < ${file} > ${file}.unix"
}

qq-sys-file-unix-to-dos() { 
  local file && __askpath file FILE $(pwd)
  print -z "sed -e 's/$/\r/' ${file} > ${file}.dos"
} 

qq-sys-file-sort-uniq() { 
  local file && __askpath file FILE $(pwd)
  print -z "cat ${file} | sort -u -o ${file}"
}

qq-sys-file-sort-uniq-ip() { 
  local file && __askpath file FILE $(pwd)
  print -z "cat ${file} | sort -u | sort -V -o ${file}"
} 
