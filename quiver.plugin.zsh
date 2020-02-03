#!/usr/bin/env zsh

############################################################# 
# quiver
# Author: Steve Mcilwain
#############################################################
__VER=0.1.0

echo " "
echo "[*] quiver loading..."

autoload colors; colors

# exports



# source all qq scripts
# for f in ${0:A:h}/qq-* ; do
#   echo "[*] quiver sourcing $f ... "
#   source $f;
# done


# output functions
__info() echo "$fg[white]$bg[blue]  \u2691  $bg[default]$fg[blue]$reset_color $1"
__ok()   echo "$fg[white]$bg[green]  \u2714  $bg[default]$fg[green]$reset_color $1"
__ok-clip() __ok "The command was copied to the clipboard."
__warn() echo "$fg[white]$bg[yellow]  \u2731  $bg[default]$fg[yellow]$reset_color $1"
__err()  echo "$fg[white]$bg[red]  \u2716  $bg[default]$fg[red]$reset_color $1"
__clip() xclip -selection c
__note() {
  echo " "
  echo "\u250f\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2513"
  echo "\u2503    Note    \u2503"
  echo "\u2517\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u251B"
  cat $1
  echo " "
}

# validation functions
__check1() { if [[ -z "$1" ]]; then return 0; fi; return 1 }
__usage() { __warn " usage: ${FUNCNAME[1]} <$1> " }

# notify
echo "[*] quiver loaded."
echo " "



############################################################# 
# PATHS
#############################################################

export __NOTES="${0:A:h}/notes"

export __WORDS_ALL="/opt/words/all/all.txt"
export __WORDS_COMMON="/usr/share/seclists/Discovery/Web-Content/common.txt"
export __WORDS_RAFT_DIRS="/usr/share/seclists/Discovery/Web-Content/raft-large-words.txt"
export __WORDS_APIOBJ="/opt/words/api_wordlist/objects.txt"
export __WORDS_MEDIUM="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
export __WORDS_RAFT_FILES="/usr/share/seclists/Discovery/Web-Content/raft-large-files.txt"
export __WORDS_SWAGGER="/usr/share/seclists/Discovery/Web-Content/swagger.txt"

export __PASS_ROCKYOU="/usr/share/wordlists/rockyou.txt"

export __UA_GOOGLEBOT="Googlebot/2.1 (+http://www.google.com/bot.html)"
export __UA_CHROME="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
export __UA_IOS="Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"

export __FDNS=""
export __RDNS=""


export __IMPACKET="/usr/share/doc/python3-impacket/examples"

############################################################# 
# Util
#############################################################

qq-util-update-quiver() {
  cd ~/.oh-my-zsh/custom/plugins/quiver
  git pull
  cd -
  source ~/.zshrc
}

alias qq-util-source-zshrc="source ~/.zshrc"

alias qq-util-to-csv="paste -s -d, -"

qq-util-get-ip() {
  curl icanhazip.com
}
qq-util-sort-file() {
  cat $1 | sort -u -o $1
}


############################################################# 
# Recon
#############################################################

qq-recon-asns-by-org-browser() {
  __info "Save in cidr.txt"
  __info https://bgp.he.net/
}

qq-recon-asns-by-org-amass() {
  local org && read "org?Org: "
  print -z "amass intel -org $org | cut -d, -f1"
}

qq-recon-cidr-by-asn-hackertarget() {
  local asn && read "asn?ASN: "
  print -z "curl https://api.hackertarget.com/aslookup/\?q\=AS$asn && echo"
}

qq-recon-cidr-by-asn-bgpview() {
  local asn && read "asn?ASN: "
  print -z "curl -s https://api.bgpview.io/asn/$asn/prefixes | jq -r '.data | .ipv4_prefixes, .ipv6_prefixes | .[].prefix'"
}

qq-recon-domains-by-whois-amass() {
  local d && read "d?Domain: "
  print -z "amass intel -active -whois -d ${d}"
}

qq-recon-domains-by-asn-amass() {
  local a && read "a?ASN: "
  print -z "amass intel -active -asn ${a}"
}

qq-recon-subs-by-domain-amass() {
  local d && read "d?Domain: "
  print -z "amass enum -d ${d}"
}

qq-recon-domains-crt.sh() {
  local s && read "s?Search (domain, url, etc): "
  print -z "curl -s https://crt.sh/\?q\=\%.${s}\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u "
}

qq-recon-subs-by-domain-subfinder() {
  local d && read "d?Domain: "
  print -z "subfinder -d ${d} -nW -silent >> domains.txt"
}

qq-recon-domains-by-url-nmap() {
  local u && read "u?Url: "
  print -z "nmap -vvv -Pn -p 80,443 --script dns-brute ${u}"
}

qq-recon-subs-by-domain-dnsrecon() {
  local domain && read "domain?Domain: "
  print -z "dnsrecon -d ${domain}"
}

qq-recon-domains-crt.sh-httprobe() {
  local s && read "s?Search: "
  print -z "curl -s https://crt.sh/\?q\=\%.${s}\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u  "
}

qq-recon-files-metagoofil() {
  local domain && read "domain?Domain: "
  local ft && read "ft?File type: "
  print -z "metagoofil -d ${domain} -t ${ft} -o files"
}

qq-recon-wordlist-by-website-cewl() {
  __check-UA
  local website && read "website?Website: "
  print -z "cewl -a -d 3 -m 5 -u \"${__UA}\" -w tmp.list ${website} && \
    john --wordlist=tmp.list --rules --stdout"
}

qq-recon-email-by-domain-theharvester() {
  local domain && read "domain?Domain: "
  print -z "theharvester -d ${domain} -l 50 -b all -n -t -e 1.1.1.1"
}

############################################################# 
# Web
#############################################################

qq-enum-web-sweep-nmap() {
  local subnet && read "subnet?Subnet (range): "
  print -z "nmap -n -Pn -sS -p80,443,8080 -oA web_sweep ${subnet} && \
  grep open web_sweep.gnmap |cut -d' ' -f2 > web_hosts.txt"
}

qq-enum-web-tcpdump() {
  local i && read "i?Interface: "
  local r && read "r?Remote Host: "
  print -z "tcpdump -i ${i} host ${r} and tcp port 80 -w web.${r}.pcap"
}

qq-enum-web-dir-robots() {
  local u && read "u?Url: "
  print -z "curl -v --user-agent \"${__UA}\" ${u}/robots.txt > web.robots.txt"
}

qq-enum-web-dir-robots-parsero() {
  local u && read "u?Url: "
  print -z "parsero -u ${u} -o -sb > web.parsero.txt"
}

qq-enum-web-whatweb() {
  local s && read "s?Search: "
  print -z "whatweb ${s} -a 3"
}

qq-enum-web-scope-burp() {
  print -z ".*\.domain\.com$"
}

qq-enum-web-vhosts-gobuster() {
  local u && read "u?Url: "
  print -z "gobuster vhost -u ${u} -w /usr/share/seclists/Discovery/DNS/subdomains-top1mil-20000.txt \
  -a \"${__UA}\" -t20 -o web.vhosts.gobuster.txt"
}

qq-enum-web-dirs-wfuzz() {
  local u && read "u?Url: "
  print -z "wfuzz -c -v -L -s 0.1 -w ${__WORDS_RAFT_DIRS} -R2 --hc=404 --hh=100 ${u}/FUZZ "
}

qq-enum-web-files-wfuzz() {
  local u && read "u?Url: "
  print -z "wfuzz -c -v -L -s 0.1 -w ${__WORDS_RAFT_FILES} -R2 --hc=404 --hh=100 ${u}/FUZZ "
}

qq-enum-web-dirs-ffuf() {
  local u && read "u?Url: "
  print -z "ffuf -r -w ${__WORDS_RAFT_DIRS} -u ${u}/FUZZ -fs 100 -fc 404"
}

qq-enum-web-files-ffuf() {
  local u && read "u?Url: "
  print -z "ffuf -r -w ${__WORDS_RAFT_FILES} -u ${u}/FUZZ -fs 100 -fc 404"
}

qq-enum-web-post-json-ffuf() {
  local u && read "u?Url: "
  print -z "ffuf -w /usr/share/seclists/Fuzzing/Databases/NoSQL.txt -u ${u} -X POST -H \"Content-Type: application/json\" -d '{\"username\": \"FUZZ\", \"password\": \"FUZZ\"}' -fr \"error\" "
}

qq-enum-web-dirs-gobuster() {
  local u && read "u?Url: "
  print -z "gobuster dir -u ${u} -w ${__WORDS_RAFT_DIRS} -a \"${__UA}\" -t20 -r -k -o gobuster-dirs-${u}.txt"
}

qq-enum-web-files-gobuster() {
  local u && read "u?Url: "
  print -z "gobuster dir -u ${u} -w ${__WORDS_RAFT_FILES} -a \"${__UA}\" -t20 -r -k -o gobuster-files-${u}.txt"
}

qq-enum-web-screens-eyewitness() {
  local f && read "f?File(urls): "
  local d && read "d?Directory: "
  mkdir ./${d}
  print -z "eyewitness.py --web -f ${f} -d ./${d} --user-agent \"${__UA}\" "
}

qq-enum-web-vuln-nikto() {
  local u && read "u?Url: "
  print -z "nikto -C all -useragent \"${__UA}\" -h ${u} -output web.nikto.log"
}

qq-enum-web-vuln-nmap-rfi() {
  local r && read "r?Remote Host: "
  print -z "nmap -vv -n -Pn -p80 --script http-rfi-spider --script-args http-rfi-spider.url='/' -oN web.rfi.nmap ${r}"
}

qq-enum-web-app-wordpress() {
  local u && read "u?Url: "
  print -z "wpscan --url ${u} --enumerate tt,vt,u,vp"
}

qq-enum-web-dir-traversal-notes() {
  glow ${__NOTES}/enum-web-dir-traversal.md
}
































#sudo masscan -p4443,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,443,744$}

#massdns -r $Tools/massdns/lists/resolvers.txt -t A -o S allsubdomains.txt -w livesubdomains.messy

# sed 's/A.*//' livesubdomains.messy | sed 's/CN.*//' | sed 's/\..$//' > domains.resolved

#cat domains.resolved | httprobe -c 50 | tee http.servers

#cp http.servers $Tools
#$Tools/EyeWitness/eyewitness.py --web -f http.servers

#python $Tools/S3Scanner/s3scanner.py -l domains.resolved -o buckets.txt

#-d flag will dump all open buckets locally

#If you find open buckets you can run the useful bash look to enumerate content

#for i in $(cat buckets.txt); do aws s3 ls s3://$i; done;

#This will require basic auth key/secret which you can get for free from AWS



#!/bin/bash
#mkdir headers
#mkdir responsebody
#CURRENT_PATH=$(pwd)

#for x in $(cat $1)
#do
#        NAME=$(echo $x | awk -F/ '{print $3}')
#        curl -X GET -H "X-Forwarded-For: evil.com" $x -I > "$CURRENT_PATH/headers/$NAME"
#        curl -s -X GET -H "X-Forwarded-For: evil.com" -L $x > "$CURRENT_PATH/responsebody/$NAME"
#done




### S3

# https://github.com/jordanpotti/AWSBucketDump

# Configure AWS CLI in your Windows/Linux/Mac machine.
# Execute the below commands from the CLI
# Uploading a file — aws s3 cp test.html s3://<xyz>-uploads/
# Deleting a file — aws s3 rm s3://<xyz>-uploads/test.html
# Listing the files — aws s3 ls s3://<xyz>-uploads/

# Lazy S3
# 2) bucket_finder
# 3) AWS Cred Scanner
# 4) sandcastle
# 5) Mass3
# 6) Dumpster Diver
# 7) S3 Bucket Finder
# 8) S3Scanner