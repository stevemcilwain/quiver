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
export __UA="Googlebot/2.1 (+http://www.google.com/bot.html)"


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

__ALL="/opt/data/all/all.txt"
__FDNS=
__RDNS=


############################################################# 
# Util
#############################################################

qq-util-zshrc() source ~/.zshrc

qq-util-to-csv() paste -s -d, -

qq-util-get-ip() curl icanhazip.com

qq-util-sort-file() cat $1 | sort -u -o $1






############################################################# 
# Recon
#############################################################

qq-recon-asns-by-org-browser() {
  __info https://bgp.he.net/
}



qq-recon-asns-by-org-amass() {
  local org && read "org?Org: "
  print -z "amass intel -org $org | cut -d, -f1 >> asn.txt"
}


qq-recon-cidr-by-asn() {
  if [ __check1 ]
  then
    for asn in $(cat $1); do curl https://api.hackertarget.com/aslookup/\?q\=AS$asn && echo "" ; done
  else
    __usage "<path_to_asn.txt>"
  fi 
}


qq-recon-domains-by-whois-amass() {
  local d && read "d?Domain: "
  print -z "amass intel -active -whois -d ${d} >> domains.txt"
}

qq-recon-domains-by-asn-amass() {
  local a && read "a?ASN: "
  print -z "amass intel -active -asn ${a} >> domains.txt"
}

qq-recon-subdomains-by-domain-amass() {
  local d && read "d?Domain: "
  print -z "amass enum -d ${d} >> domains.txt"
}

qq-recon-domains-crt.sh() {
  local s && read "s?Search (domain, url, etc): "
  print -z "curl -s https://crt.sh/\?q\=\%.${s}\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u "
}

qq-recon-domains-by-domain-subfinder() {
  local d && read "d?Domain: "
  print -z "subfinder -d ${d} -nW -silent >> domains.txt"
}

qq-recon-domains-crt.sh-httprobe() {
  local s && read "s?Search: "
  print -z "curl -s https://crt.sh/\?q\=\%.${s}\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe "
}

qq-recon-active-web-whatweb() {
  local s && read "s?Search: "
  print -z "whatweb ${s} -a 3"
}









############################################################# 
# Web
#############################################################

qq-enum-web-scope-burp() {
  print -z ".*\.domain\.com$"
}

qq-enum-web-dirs-wfuzz() {

  print -z "wfuzz -c -z file,/root/necromancer/thing.txt — hc 404 http://192.168.56.102/amagicbridgeappearsatthechasm/FUZZ"
}

#gobuster dns -d paypal.com -w all.txt
#gobuster dns -d paypal.com -w commonspeak.txt

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


