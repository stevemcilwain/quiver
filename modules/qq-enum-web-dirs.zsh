#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-dirs
#############################################################

qq-enum-web-dirs-help() {
  cat << "DOC"

qq-enum-web-dirs
----------------
The qq-enum-web-dirs namespace contains commands for discovering web content, directories and files.

Commands
--------
qq-enum-web-dirs-install:      installs dependencies
qq-enum-web-dirs-robots:       get robots.txt using curl
qq-enum-web-dirs-parsero:      parse complex robots.txt with parsero
qq-enum-web-dirs-wfuzz:        brute force dirs and files with wfuzz
qq-enum-web-dirs-ffuf:         brute force dirs and files with ffuf
qq-enum-web-dirs-gobuster:     brute force dirs and files with gobuster

DOC
}

qq-enum-web-dirs-install() {

  __pkgs parsero gobuster wfuzz curl seclists wordlists 

  qq-install-golang
  go get -u github.com/ffuf/ffuf
  go get -v -u github.com/tomnomnom/httprobe
  
}

qq-enum-web-dirs-robots() {
  __check-project
  qq-vars-set-url
  print -z "curl -s -L --user-agent \"${__UA}\" \"${__URL}/robots.txt\" | tee $(__urlpath)/robots.txt"
}

qq-enum-web-dirs-parsero() {
  __check-project
  qq-vars-set-url
  print -z "parsero -u \"${__URL}\" -o -sb | tee $(__urlpath)/robots.txt"
}

qq-enum-web-dirs-wfuzz() {
  __check-project
  qq-vars-set-url
  qq-vars-set-wordlist
  local d && __askvar d "RECURSION DEPTH"
  print -z "wfuzz -s 0.1 -R${d} --hc=404 -w ${__WORDLIST} ${__URL}/FUZZ --oF $(__urlpath)/wfuzz-dirs.txt"
}

qq-enum-web-dirs-ffuf() {
  __check-project
  qq-vars-set-url
  qq-vars-set-wordlist
  __check-threads
  local d && __askvar d "RECURSION DEPTH"
  print -z "ffuf -p 0.1 -t ${__THREADS} -recursion -recursion-depth ${d} -H \"User-Agent: Mozilla\" -fc 404 -w ${__WORDLIST} -u ${__URL}/FUZZ -o $(__urlpath)/ffuf-dirs.csv -of csv"
}

qq-enum-web-dirs-gobuster() {
  __check-project
  qq-vars-set-url
  qq-vars-set-wordlist
  __check-threads
  print -z "gobuster dir -u ${__URL} -a \"${__UA}\" -t1 -k -w ${__WORDLIST} | tee $(__urlpath)/gobuster-dirs.txt "
}
