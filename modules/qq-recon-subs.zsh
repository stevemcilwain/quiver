#!/usr/bin/env zsh

############################################################# 
# qq-recon-subs
#############################################################

qq-recon-subs-by-domain-amass() {
  local d && read "d?DOMAIN: "
  print -z "amass enum -d ${d} >> subs.${d}.txt"
}

qq-recon-subs-by-domain-crt.sh() {
  local d && read "d?DOMAIN: "
  print -z "curl -s 'https://crt.sh/?q=%.${d}' | grep -i \"${d}\" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v \" \" | sort -u >> subs.${d}.txt"
}

qq-recon-subs-by-domains-crt.sh() {
  local f=$(rlwrap -S 'FILE(DOMAINS): ' -e '' -c -o cat)
  cmd="curl -s 'https://crt.sh/?q=%.\${d}' | grep -i \"\${d}\" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v \" \" | sort -u >> subs.\${d}.txt"
  print -z "for d in \$(cat ${f}); do ${cmd} ; done"
}

qq-recon-subs-by-domain-subfinder() {
  local d && read "d?DOMAIN: "
  print -z "subfinder -d ${d} -nW -silent >> subs.${d}.txt"
}

qq-recon-subs-by-domain-sublist3r() {
  local d && read "d?DOMAIN: "
  print -z "sublist3r -d ${d} -b -p 80,443,8080,4443 -t 10 -e Baido,Yahoo,Google,Bing,Ask,Netcraft,VirusTotal,SSL,ThreatCrowd,PassiveDNS -o subs.${d}.txt"
}

qq-recon-subs-by-domain-dnsrecon() {
  local d && read "d?DOMAIN: "
  print -z "dnsrecon -d ${d}"
}

qq-recon-subs-massdns() {
  local f=$(rlwrap -S 'FILE(DOMAINS): ' -e '' -c -o cat) 
  print -z "/opt/recon/massdns/bin/massdns -r /opt/recon/massdns/lists/resolvers.txt -t A -o S ${f} -w massdns.results.txt"
}

qq-recon-subs-massdns-results-parse() {
  local f=$(rlwrap -S 'Select results file: ' -e '' -c -o cat)
  print -z "sed 's/A.*//' ${f} | sed 's/CN.*//' | sed 's/\..$//' > massdns.clean.txt"
}

qq-recon-subs-gen-commonspeak-words() {
  local d && read "d?Domain: "
  print -z "for s in \$(cat /opt/words/commonspeak2-wordlists/subdomains/subdomains.txt); do echo \$s.${d} >> subs.wordlist.${d}.txt; done"
}

qq-recon-subs-by-brute-altdns() {
  local f=$(rlwrap -S 'Select domains file: ' -e '' -c -o cat)
  local w=$(rlwrap -S 'Select wordlist: ' -e '' -c -o cat)
  print -z "altdns -r -i ${f} -w ${w} -t 20 -o altsub.data.txt -s altsub.resolved.txt"
}
