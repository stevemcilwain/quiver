#!/usr/bin/env zsh

############################################################# 
# Recon
#############################################################

[[ -z $1 ]] && echo -e "[!] Missing argument.\nUsage: zsh $0 <domain> <org>" && exit
[[ -z $2 ]] && echo -e "[!] Missing argument.\nUsage: zsh $0 <domain> <org>" && exit

DOMAIN=$1
ORG=$2

echo "[*] Recon.zsh running... "
echo "[*] $DOMAIN $ORG "

echo "[*] Collection sub-domains..."

echo " [+] Subfinder'ing "
subfinder -d $DOMAIN -nW -silent >> subs.txt

echo " [+] crt.sh'ing "
curl -s 'https://crt.sh/?q=%.$DOMAIN' | grep -i "$DOMAIN" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v " " | sort -u >> subs.txt

echo " [+] waybackurls'ing... "
echo $DOMAIN | waybackurls | cut -d "/" -f3 | sort -u | grep -v ":80" >> subs.txt

echo " [+] sorting subs.txt "
cat subs.txt | sort -u -o subs.txt

echo " [+] massdns'ing into resolved.txt"
/opt/recon/massdns/bin/massdns -r /opt/recon/massdns/lists/resolvers.txt -t A -o S subs.txt -w resolved.txt




