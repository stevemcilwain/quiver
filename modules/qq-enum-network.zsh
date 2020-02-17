#!/usr/bin/env zsh

############################################################# 
# qq-enum-network
#############################################################

qq-enum-network-1-ping-sweep() {
  local s && read "s?SUBNET: "
  print -z "nmap -vvv -sn --open -oA ping_sweep ${s} && cat ping_sweep.gnmap | grep Up | cut -d" " -f2 >> hosts.txt"
}

qq-enum-network-2-syn-sweep() {
  local s && read "s?SUBNET: "
  print -z "nmap -vvv -n -Pn --open -sS -oA syn_sweep --excludefile hosts.txt ${s} && cat syn_sweep.gnmap | grep Up | cut -d" " -f2 >> hosts.txt"
}

qq-enum-network-3-udp-sweep() {
  local s && read "s?SUBNET: "
  print -z "nmap -vvv -n -Pn --open -sU --top-ports 100 -oA udp_sweep --excludefile hosts.txt ${s} && cat udp_sweep.gnmap | grep Up | cut -d" " -f2 >> hosts.txt"
}

qq-enum-network-4-all-sweep() {
  local s && read "s?SUBNET: "
  print -z "nmap -vvv -n -Pn -T4 --open -sS -p- -oA syn_all --excludefile hosts.txt ${s} && cat syn_all.gnmap | grep Up | cut -d" " -f2 >> hosts.txt"
}

qq-enum-network-5-discovery() {
  print -z "nmap -vvv -n -Pn -sV -sC -iL hosts.txt -oA network_discovery && searchsploit -x --nmap network_discovery.xml |grep remote"
}

qq-enum-network-sort-hosts() {
  print -z "cat hosts.txt | sort -u | sort -V"
}

__MASSCAN_PORTS="161,443,744,2075,2076,3000,3306,3366,3868,4000,4040,4044,4443,5000,5432,5900,6000,6443,7077,8000,8080,8081,8089,8181,8443,8888,9000,9091,9443,9999,10000,15672"

qq-enum-network-masscan() {
  local s && read "s?SUBNET: "
  local f=$(echo $s | cut -d/ -f1)
  print -z "masscan ${s} -p${__MASSCAN_PORTS} -oL masscan.${f}.txt "
}

qq-enum-networks-masscan() {
  local f=$(rlwrap -S 'FILE(CIDRs): ' -e '' -c -o cat)
  print -z "for c in \$(cat ${f}); do n=\$(echo \$c | cut -d/ -f1) && masscan ${c} -p${__MASSCAN_PORTS} -oL masscan.\${n}.txt ; done"
}


