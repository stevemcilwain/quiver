#!/usr/bin/env zsh

############################################################# 
# qq-enum-web
#############################################################

qq-enum-web-help() {
  cat << END

qq-enum-web
-----------
The qq-enum-web namespace contains commands for scanning and enumerating
http services.

Commands
--------
qq-enum-web-install:                installs dependencies
qq-enum-web-tcpdump:                capture traffic to and from a host
qq-enum-web-nmap-sweep:             nmap sweep scan to discover web servers on a network
qq-enum-web-whatweb:                enumerate web server and platform information
qq-enum-web-waf:                    enumerate WAF information
qq-enum-web-vhosts-gobuster:        brute force for virtual hosts
qq-enum-web-eyewitness:             scrape screenshots from target URL
qq-enum-web-wordpress:              enumerate Wordpress information
qq-enum-web-headers:                grab headers from a target url using curl
qq-enum-web-mirror:                 mirrors the target website locally
END
}

qq-enum-web-install() {

  __pkgs tcpdump nmap whatweb wafw00f gobuster eyewitness wpscan wget curl seclists wordlists 

}

qq-enum-web-nmap-sweep() {
  __check-project
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -p80,443,8080 ${__NETWORK} -oA $(__netpath)/web-sweep"
}

qq-enum-web-tcpdump() {
  __check-project
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 80 -w $(__hostpath)/web.pcap"
}

qq-enum-web-whatweb() {
  __check-project
  qq-vars-set-url
  print -z "whatweb ${__URL} -a 3 > $(__urlpath)/whatweb.txt"
}

qq-enum-web-waf() {
  __check-project
  qq-vars-set-url
  print -z "wafw00f ${__URL} -o $(__urlpath)/waf.txt"
}

# vhosts

qq-enum-web-vhosts-gobuster() {
  __check-project
  qq-vars-set-url
  local w && __askpath w FILE /usr/share/seclists/Discovery/DNS/subdomains-top1mil-20000.txt
  __check-threads
  print -z "gobuster vhost -u ${__URL} -w ${w} -a \"${__UA}\" -t ${__THREADS} -o $(__urlpath)/vhosts.txt"
}

# screens

qq-enum-web-eyewitness() {
  __check-project
  qq-vars-set-url
  mkdir -p $(__urlpath)/screens
  print -z "eyewitness --web --no-dns --no-prompt --single ${__URL} -d $(__urlpath)/screens --user-agent \"${__UA}\" "
}

# apps

qq-enum-web-wordpress() {
  __check-project
  qq-vars-set-url
  print -z "wpscan --ua \"${__UA}\" --url ${__URL} --enumerate tt,vt,u,vp -o $(__urlpath)/wpscan.txt"
}

qq-enum-web-headers() {
  __check-project
  qq-vars-set-url
  print -z "curl -s -X GET -I -L -A \"${__UA}\" \"${__URL}\" > $(__urlpath)/headers.txt"
}

qq-enum-web-mirror() {
  __warn "The destination site will be mirrored in the current directory"
  qq-vars-set-url
  print -z "wget -mkEpnp ${__URL} "
}

