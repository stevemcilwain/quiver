#!/usr/bin/env zsh

#continue on errors
set +e 

############################################################# 
# Recon
#############################################################

[[ -z $1 ]] && echo -e "[!] Missing argument.\nUsage: zsh $0 <domain> <org>" && exit
[[ -z $2 ]] && echo -e "[!] Missing argument.\nUsage: zsh $0 <domain> <org>" && exit

export DOMAIN=$1
export ORG=$2
export DIR=$(pwd)
export UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"

export F_ASN="net.asn.txt"
export F_CIDR="net.cidr.txt"
export F_PTR="net.ptr"
export F_SUBS="subs.txt"
export F_SUBS_RES="subs.resolved.txt"
export F_HOSTS="hosts.names.txt"
export F_HOSTS_IP="hosts.ip.txt"
export F_WEB="hosts.web.txt"

export PORTS="21,22,25,80,443,135-139,445,3389,3306,1433,389,636,88,111,2049,1521,110,143,161,6379,5900,2222,4443,8000,8888,8080,9200"


############################################################# 
# Helpers
#############################################################

silent() {
    "$@" > /dev/null 2>&1
}

############################################################# 
# Startup
#############################################################

echo "[*] Recon.zsh running... "
echo "[*] Domain: ${DOMAIN} Org: ${ORG}"
echo "[*] Using current directory for output: ${DIR}"

############################################################# 
# Steps
#############################################################

org() {

    echo " [+] metagoofil'ing files"
    mkdir -p ${DIR}/files
    silent metagoofil -u "${UA}" -d ${DOMAIN} -t pdf,doc,docx,ppt,pptx,xls,xlsx -l 100 -n 50 -o ${DIR}/files
}

network() {

    echo " [+] Amass'ing ASNs"
    silent amass intel -org ${ORG} | cut -d, -f1 | tee -a ${F_ASN}

    echo " [+] BGPview'ing CIDRs"
    for asn in $(cat ${F_ASN})
    do 
        silent curl -s https://api.bgpview.io/asn/${asn}/prefixes | jq -r '.data | .ipv4_prefixes | .[].prefix' | tee -a ${F_CIDR}
    done

    echo " [+] dnsrecon'ing PTRs"
    mkdir -p ${DIR}/NET/PTR

    for cidr in $(cat ${F_CIDR})
    do 
        local net=$(echo ${cidr} | cut -d/ -f1) 
        silent dnsrecon -d ${DOMAIN} -r ${cidr} -n 1.1.1.1 -c ${DIR}/NET/PTR/${F_PTR}.${net}.csv
    done

    echo " [+] masscan'ing CIDRs"
    mkdir -p ${DIR}/NET

    for cidr in $(cat ${F_CIDR})
    do 
        local net=$(echo ${cidr} | cut -d/ -f1) 
        silent sudo masscan ${cidr} -p${PORTS} -oL ${DIR}/NET/masscan.${net}.txt
    done

}

domains() {

    echo " [+] Subfinder'ing "
    silent subfinder -d ${DOMAIN} -nW -silent | tee -a ${F_SUBS}

    echo " [+] crt.sh'ing "
    silent curl -s 'https://crt.sh/?q=%.$DOMAIN' | grep -i "${DOMAIN}" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v " " | sort -u | tee -a ${F_SUBS}

    echo " [+] waybackurls'ing... "
    silent echo ${DOMAIN} | waybackurls | cut -d "/" -f3 | sort -u | grep -v ":80" | tee -a ${F_SUBS}

    echo " [+] sorting results "
    silent cat ${F_SUBS} | sort -u -o ${F_SUBS}

}

lookups() {

    echo " [+] massdns'ing domains"
    silent /opt/recon/massdns/bin/massdns -r /opt/recon/massdns/lists/resolvers.txt -t A -o S ${F_SUBS} -w ${F_SUBS_RES}

    echo " [+] extracting resolved hostnames"

    silent sed 's/A.*//' ${F_SUBS_RES} | sed 's/CN.*//' | sed 's/\..$//' | sort -u >> ${F_HOSTS}

    echo " [+] extracting resolved IP addresses"
    silent grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'  ${F_SUBS_RES}  | sort -u | sort -V -o ${F_HOSTS_IP}
}

scans() {

    echo " [+] scanning host IP's"
    mkdir -p ${DIR}/hosts

    for h in $(cat ${F_HOSTS_IP})
    do
        echo " [+] scanning ${h}"

        mkdir -p ${DIR}/hosts/${h}

        silent nmap -sT -p ${PORTS} -T4 --open ${h} -oA ${DIR}/hosts/${h}/scan 
    done

}

web() {

    echo " [+] httprobing resolved hosts"
    cat ${F_SUBS_RES} | httprobe -t 3000 -s -p https:443 | sed 's/....$//' >> ${F_WEB}

    mkdir -p ${DIR}/web

    for url in $(cat ${F_WEB})
    do
        echo " [*] enumerating ${url} ... "

        local host=$(echo ${url} | cut -d/ -f3)
        local hdir=${DIR}/web/${host}

        mkdir -p ${hdir}

        echo " [+] Getting IP address"
        silent host ${host} | tee ${hdir}/ip.txt 

        echo " [+] Curling robots.txt" 
        silent curl -s -L ${url}/robots.txt -o ${hdir}/robots.txt

        echo " [+] Whatwebbing"
        silent whatweb ${url} -a 1 | tee ${hdir}/whatweb.txt 
    
        echo " [+] Wafw00fing"
        silent wafw00f ${url} | tee ${hdir}/waf.txt

        echo " [+] Gobustering"
        silent gobuster dir -q -z -u ${url} -w /usr/share/seclists/Discovery/Web-Content/common.txt -t10 -k -o ${hdir}/gobuster.txt

        echo " [+] S3 Bucketing"
        silent aws s3 ls s3://${host} | tee s3.txt 

    done

}

############################################################# 
# Workflow
#############################################################

echo "[*] Collecting Org Data... "

org

echo "[*] Collecting Network Information... "

network

echo "[*] Collection sub-domains..."

domains 

echo "[*] Scanning resolved..."

scans

echo "[*] Scanning web servers..."

web

echo "[*] Recon completed"

echo " "
