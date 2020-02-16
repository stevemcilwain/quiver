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

qq-recon-subs-massdns() {
  local p && read "p?Path to list: "
  print -z "/opt/recon/massdns/bin/massdns -r /opt/recon/massdns/list/resolvers.txt -t A -o S ${p} -w massdns.results.txt"
}

qq-recon-subs-massdns-results-parse() {
  local p && read "p?Path to results: "
  print -z "sed 's/A.*//' ${p} | sed 's/CN.*//' | sed 's/\..$//' > massdns.clean.txt"
}

qq-recon-subs-gen-commonspeak-words() {
  local d && read "d?Domain: "
  print -z "for s in $(cat /opt/words/commonspeak2-wordlists/subdomains/subdomains.txt); do echo \$s.test.com | tee -a subs.wordlist.${d}.txt; done"
}

qq-recon-subs-by-brute-altdns() {
  local r && read "r?Root domain list: "
  local w && read "w?Word list: "
  print -z "altdns -r -i ${r} -w ${w} -t 20 -o altsub.data.txt -s altsub.resolved.txt"
}
