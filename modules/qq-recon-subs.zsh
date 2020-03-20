#!/usr/bin/env zsh

############################################################# 
# qq-recon-subs
#############################################################

qq-recon-subs-by-domain-gobuster() {
  qq-vars-set-domain
  print -z "gobuster dns -d ${__DOMAIN} -c -i -w /usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt"
}

qq-recon-subs-by-domain-amass() {
  qq-vars-set-domain
  print -z "amass enum -d ${__DOMAIN}"
}

qq-recon-subs-by-domain-crt.sh() {
  qq-vars-set-domain
  print -z "curl -s 'https://crt.sh/?q=%.${__DOMAIN}' | grep -i \"${d}\" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v \" \" | sort -u"
}

qq-recon-subs-by-domains-crt.sh() {
  local f=$(rlwrap -S 'FILE(DOMAINS): ' -e '' -c -o cat)
  cmd="curl -s 'https://crt.sh/?q=%.\${d}' | grep -i \"\${d}\" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v \" \" | sort -u >> subs.\${d}.txt"
  print -z "for d in \$(cat ${f}); do ${cmd} ; done"
}

qq-recon-subs-by-domain-subfinder() {
  qq-vars-set-domain
  print -z "subfinder -d ${__DOMAIN} -nW -silent"
}

qq-recon-subs-by-domain-sublist3r() {
  qq-vars-set-domain
  print -z "sublist3r -d ${__DOMAIN} -b -p 80,443,8080,4443 -t 10 -e Baido,Yahoo,Google,Bing,Ask,Netcraft,VirusTotal,SSL,ThreatCrowd,PassiveDNS"
}

qq-recon-subs-by-domain-dnsrecon() {
  qq-vars-set-domain
  print -z "dnsrecon -d ${__DOMAIN}"
}

qq-recon-subs-by-file-massdns() {
  local f=$(rlwrap -S 'FILE(DOMAINS): ' -e '' -c -o cat) 
  print -z "/opt/recon/massdns/bin/massdns -r /opt/recon/massdns/lists/resolvers.txt -t A -o S ${f} -w massdns.results.txt"
}

qq-recon-subs-massdns-results-parse() {
  local f=$(rlwrap -S 'FILE(results): ' -e '' -c -o cat)
  print -z "sed 's/A.*//' ${f} | sed 's/CN.*//' | sed 's/\..$//' | sort -u > massdns.clean.txt"
}

qq-recon-subs-gen-commonspeak-words() {
  qq-vars-set-domain
  print -z "for s in \$(cat /opt/words/commonspeak2-wordlists/subdomains/subdomains.txt); do echo \$s.${__DOMAIN} >> subs.wordlist.${d}.txt; done"
}

qq-recon-subs-by-brute-altdns() {
  local f=$(rlwrap -S 'FILE(domains): ' -e '' -c -o cat)
  local w=$(rlwrap -S 'FILE(wordlist): ' -e '' -c -o cat)
  print -z "altdns -r -i ${f} -w ${w} -t 20 -o altsub.data.txt -s altsub.resolved.txt"
}

qq-recon-subs-by-file-wayback() {
  local f=$(rlwrap -S 'FILE(DOMAINS): ' -e '' -c -o cat) 
  print -z "cat ${f} | waybackurls | cut -d "/" -f3 | sort -u | grep -v \":80\" >> subs.txt"
}
