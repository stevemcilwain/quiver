#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

echo -e "[*] webrecon.sh "
echo -e "[*] source: $1"
echo -e " "

for url in $(cat $1);do 
    echo -e "[*] Enumerating ${url}"

    ############################################################
    # Make directory
    ############################################################

    host=$(echo $url | cut -d "/" -f3)

    echo -e "${green} [+] Making directory ${host} ${reset}"
    mkdir -p ${host}

    ############################################################
    # Host
    ############################################################
    echo -e "${green} [+] Getting IP address... ${reset}"
    host ${host} | tee ${host}/ip.txt > /dev/null
 
    ############################################################
    # Robots
    ############################################################
    echo -e "${green} [+] Curling... robots.txt ${reset}" 
    curl -s ${url}/robots.txt -o ${host}/robots.txt

    ############################################################
    # Ports
    ############################################################
    echo -e "${green} [+] Nmapping... ${reset}"
    nmap -sV --version-light -p 80,443 --open ${host} -oA ${host}/ports > /dev/null 

    ############################################################
    # Whatweb
    ############################################################
    echo -e "${green} [+] Whatwebbing... ${reset}"
    whatweb ${url} -a 1 > ${host}/whatweb.txt 2> /dev/null

    ############################################################
    # Gobuster
    ############################################################
    echo -e "${green} [+] Gobustering... ${reset}"
    gobuster dir -q -z -u ${url} -w /usr/share/seclists/Discovery/Web-Content/quickhits.txt -k -o gobuster-dirs.txt
  
    ############################################################
    # Eyewitness
    ############################################################
    echo -e "${green} [+] Screenshotting... ${reset}"
    eyewitness --web --single ${url} -d ./${host}/screens --no-prompt &> /dev/null


    echo -e " "
done

echo -e " "
echo -e "[*] Done"