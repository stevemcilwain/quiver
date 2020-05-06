#!/usr/bin/env zsh

############################################################# 
# qq-recon-subs
#############################################################

qq-recon-subs-help() {
  cat << END

qq-recon-subs
-------------
The recon namespace provides commands to recon vertical sub-domains of a root domain.

Commands
--------
qq-recon-subs-install: installs dependencies
qq-recon-subs-gobuster: brute force subdomain search using gobuster and a wordlist
qq-recon-subs-amass: enumerate subdomains using amass
qq-recon-subs-amass-diff: track changes between last 2 enumerations using amass


END
}

qq-recon-subs-install() {
  sudo apt-get golang
  sudo apt-get gobuster
  sudo apt-get amass
  sudo apt-get curl
  sudo apt-get install sublist3r
  sudo apt-get install seclists
  sudo apt-get install dnsrecon
}

qq-recon-subs-gobuster() {
  qq-vars-set-output
  qq-vars-set-domain
  local t && read "t?$(__cyan THREADS: )"
  local dd=${__OUTPUT}/domains/${__DOMAIN}
  mkdir -p ${dd}
  print -z "gobuster dns -r 8.8.8.8 -t ${t} --wildcard -d ${__DOMAIN} -c -i -w /usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt" -o ${dd}/subs-gobuster.txt
}

qq-recon-subs-amass() {
  qq-vars-set-output
  qq-vars-set-domain
  mkdir -p ${__OUTPUT}/domains/amass
  print -z "amass enum -active -ip -d ${__DOMAIN} -dir ${__OUTPUT}/domains/amass"
}

qq-recon-subs-amass-diff() {
  qq-vars-set-output
  qq-vars-set-domain
  mkdir -p ${__OUTPUT}/domains/amass
  print -z "amass track -d ${__DOMAIN} -last 2 -dir ${__OUTPUT}/domains/amass"
}

qq-recon-subs-crt.sh() {
  qq-vars-set-output
  qq-vars-set-domain
  local dd=${__OUTPUT}/domains/${__DOMAIN}
  mkdir -p ${dd}
  print -z "curl -s 'https://crt.sh/?q=%.${__DOMAIN}' | grep -i \"${__DOMAIN}\" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v \" \" | sort -u > ${dd}/subs-crt.txt "
}

qq-recon-subs-crt.sh-file() {
  qq-vars-set-output
  mkdir -p ${__OUTPUT}/domains
  local f=$(rlwrap -S "$(__cyan FILE\(DOMAINS\): )" -P \"${__OUTPUT}\" -e '' -c -o cat)
  cmd="curl -s 'https://crt.sh/?q=%.\${d}' | grep -ie \"\${d}\" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v \" \" | sort -u >> ${__OUTPUT}/domains/subs.\${d}.txt"
  print -z "for d in \$(cat ${f}); do ${cmd} ; done"
}

qq-recon-subs-subfinder() {
  qq-vars-set-output
  qq-vars-set-domain
  local t && read "t?$(__cyan THREADS: )"
  local dd=${__OUTPUT}/domains/${__DOMAIN}
  mkdir -p ${dd}
  print -z "subfinder -t ${t} -d ${__DOMAIN} -nW -silent -o ${dd}/subs-subfinder.txt"
}

qq-recon-subs-sublist3r() {
  qq-vars-set-output
  qq-vars-set-domain
  local t && read "t?$(__cyan THREADS: )"
  local dd=${__OUTPUT}/domains/${__DOMAIN}
  mkdir -p ${dd}
  print -z "sublist3r -d ${__DOMAIN} -b -p 80,443,8080,4443 -t ${t} -e Baido,Yahoo,Google,Bing,Ask,Netcraft,VirusTotal,SSL,ThreatCrowd,PassiveDNS -o $dd/subs-sublist3r.txt"
}

qq-recon-subs-dnsrecon() {
  qq-vars-set-output
  qq-vars-set-domain
  local dd=${__OUTPUT}/domains/${__DOMAIN}
  mkdir -p ${dd}
  print -z "dnsrecon -d ${__DOMAIN} -t brt -D /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -c $dd/subs.csv "
}



qq-recon-subs-by-file-massdns() {
  local f=$(rlwrap -S "$fg[cyan]FILE(DOMAINS):$reset_color " -e '' -c -o cat) 
  print -z "/opt/recon/massdns/bin/massdns -r /opt/recon/massdns/lists/resolvers.txt -t A -o S ${f} -w massdns.results.txt"
}

qq-recon-subs-massdns-results-parse() {
  local f=$(rlwrap -S "$fg[cyan]FILE(results):$reset_color " -e '' -c -o cat)
  print -z "sed 's/A.*//' ${f} | sed 's/CN.*//' | sed 's/\..$//' | sort -u > massdns.clean.txt"
}

qq-recon-subs-gen-commonspeak-words() {
  qq-vars-set-domain
  print -z "for s in \$(cat /opt/words/commonspeak2-wordlists/subdomains/subdomains.txt); do echo \$s.${__DOMAIN} >> subs.wordlist.${d}.txt; done"
}

qq-recon-subs-by-brute-altdns() {
  local f=$(rlwrap -S "$fg[cyan]FILE(domains):$reset_color " -e '' -c -o cat)
  local w=$(rlwrap -S "$fg[cyan]FILE(wordlist):$reset_color " -e '' -c -o cat)
  print -z "altdns -r -i ${f} -w ${w} -t 20 -o altsub.data.txt -s altsub.resolved.txt"
}

qq-recon-subs-by-file-wayback() {
  local f=$(rlwrap -S "$fg[cyan]FILE(DOMAINS):$reset_color " -e '' -c -o cat) 
  print -z "cat ${f} | waybackurls | cut -d "/" -f3 | sort -u | grep -v \":80\" >> subs.txt"
}
