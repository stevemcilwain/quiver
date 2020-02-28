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

export F_ASN="${DIR}/asn.txt"
export F_CIDR="${DIR}/cidr.txt"
export F_SUBS="${DIR}/subs.txt"
export F_SUBS_RES="${DIR}/subs.resolved.txt"
export F_HOSTS="${DIR}/hostnames.txt"
export F_HOSTS_IP="${DIR}/hostips.txt"
export F_WEB="${DIR}/urls.txt"

export PORTS="21,22,25,80,443,135-139,445,3389,3306,1433,389,636,88,111,2049,1521,110,143,161,6379,5900,2222,4443,8000,8888,8080,9200"

export HIDE=/dev/null 2>&1

# MAXJOBS=10
# while [ $(jobs | wc -l) -ge ${MAXJOBS} ] ; do sleep 1 ; done

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
    metagoofil -u "${UA}" -d ${DOMAIN} -t pdf,doc,docx,ppt,pptx,xls,xlsx -l 100 -n 50 -o ${DIR}/files &
}

network() {

    echo " [+] Amass'ing ASNs"
    amass intel -org "${ORG}" | cut -d, -f1 >> ${F_ASN}

    echo " [+] BGPview'ing CIDRs"
    for asn in $(cat ${F_ASN})
    do 
        if [[ ! -z ${asn} ]]
        then 
            curl -s https://api.bgpview.io/asn/${asn}/prefixes | jq -r '.data | .ipv4_prefixes | .[].prefix' >> ${F_CIDR}
        fi
    done

    echo " [+] dnsrecon'ing PTRs"
    network_dnsrecon &


    echo " [+] masscan'ing CIDRs"
    network_masscan &

}

network_dnsrecon() {
    mkdir -p ${DIR}/ptr
    for cidr in $(cat ${F_CIDR})
    do 
        if [[ ! -z ${cidr} ]]
        then
            local net=$(echo ${cidr} | cut -d/ -f1) 
            dnsrecon -d ${DOMAIN} -r ${cidr} -n 1.1.1.1 -c ${DIR}/ptr/ptr.${net}.csv > HIDE
        fi
    done
}

network_masscan() {
    mkdir -p ${DIR}/net
    for cidr in $(cat ${F_CIDR})
    do
        if [[ ! -z ${cidr} ]]
        then
            local net=$(echo ${cidr} | cut -d/ -f1) 
            sudo masscan ${cidr} -p${PORTS} -oL ${DIR}/net/masscan.${net}.txt > HIDE 
        fi
    done
}




domains() {

    echo "${DOMAIN}" > ${DIR}/domains.txt

    echo " [+] Subfinder'ing "
    subfinder -d ${DOMAIN} -nW -silent >> ${F_SUBS}

    echo " [+] crt.sh'ing "
    curl -s 'https://crt.sh/?q=%.$DOMAIN' | grep -i "${DOMAIN}" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v " " | sort -u >> ${F_SUBS}

    echo " [+] waybackurls'ing... "
    echo ${DOMAIN} | waybackurls | cut -d "/" -f3 | sort -u | grep -v ":80" >> ${F_SUBS}

    echo " [+] sorting results "
    cat ${F_SUBS} | sort -u -o ${F_SUBS}

}

lookups() {

    echo " [+] massdns'ing domains"
    /opt/recon/massdns/bin/massdns -r /opt/recon/massdns/lists/resolvers.txt -t A -o S ${F_SUBS} -w ${F_SUBS_RES}

    echo " [+] extracting resolved hostnames"

    sed 's/A.*//' ${F_SUBS_RES} | sed 's/CN.*//' | sed 's/\..$//' | sort -u >> ${F_HOSTS}

    echo " [+] extracting resolved IP addresses"
    grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'  ${F_SUBS_RES} | sort -u | sort -V -o ${F_HOSTS_IP}
}

scans() {

    echo " [+] scanning host IP's"
    mkdir -p ${DIR}/hosts

    for h in $(cat ${F_HOSTS_IP})
    do
        echo " [+] scanning ${h}"

        mkdir -p ${DIR}/hosts/${h}

        nmap -sT -p ${PORTS} -T4 --open ${h} -oA ${DIR}/hosts/${h}/scan 
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
        host ${host} > ${hdir}/ip.txt 

        echo " [+] Curling robots.txt" 
        curl -s -L ${url}/robots.txt -o ${hdir}/robots.txt

        echo " [+] Whatwebbing"
        whatweb ${url} -a 1 > ${hdir}/whatweb.txt 
    
        echo " [+] Wafw00fing"
        wafw00f ${url} > ${hdir}/waf.txt

        echo " [+] Gobustering"
        gobuster dir -q -z -u ${url} -w /usr/share/seclists/Discovery/Web-Content/common.txt -t10 -k -o ${hdir}/gobuster.txt

        echo " [+] S3 Bucketing"
        aws s3 ls s3://${host} > s3.txt 

    done

}

############################################################# 
# Workflow
#############################################################

echo "[*] Collecting Org Data... "

#org

echo "[*] Collecting Network Information... "

network

echo "[*] Collection sub-domains..."

#domains 

echo "[*] Scanning resolved..."

#scans

echo "[*] Scanning web servers..."

#web

echo "[*] Checking job completion..."

wait $(jobs -p)

echo "[*] Recon completed"

echo " "
