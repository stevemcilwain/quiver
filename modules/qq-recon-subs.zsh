#!/usr/bin/env zsh

############################################################# 
# qq-recon-subs
#############################################################

qq-recon-subs-by-domain-amass() {
  local d && read "d?Domain: "
  print -z "amass enum -d ${d} >> subs.${d}.txt"
}

qq-recon-subs-by-domain-crt.sh() {
  local d && read "d?Domain: "
  print -z "curl 'https://crt.sh/?q=%.${d}' | grep -i "${d}" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v " " | sort -u >> subs.${d}.txt"
}

qq-recon-subs-by-domain-subfinder() {
  local d && read "d?Domain: "
  print -z "subfinder -d ${d} -nW -silent >> subs.${d}.txt"
}

qq-recon-subs-by-domain-sublist3r() {
  local d && read "d?Domain: "
  print -z "python3 sublist3r.py -d ${d} -b -p 80,443,8080,4443 -t 10 -e Baido,Yahoo,Google,Bing,Ask,Netcraft,VirusTotal,SSL,ThreatCrowd,PassiveDNS -o subs.${d}.txt"
}

qq-recon-subs-by-domain-dnsrecon() {
  local d && read "domain?Domain: "
  print -z "dnsrecon -d ${d}"
}
