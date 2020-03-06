#!/usr/bin/env zsh

autoload colors; colors

############################################################# 
# quiver
# Author: Steve Mcilwain
# Contributors: 
#############################################################

export __VER=0.11.1

############################################################# 
# Constants
#############################################################

export __PLUGIN="${0:A:h}"
export __LOGFILE="${__PLUGIN}/log.txt"
export __SCRIPTS="${0:A:h}/scripts"

export __WORDS_ALL="/opt/words/all/all.txt"
export __WORDS_NULL="/opt/words/nullenc/null.txt"
export __WORDS_COMMON="/usr/share/seclists/Discovery/Web-Content/common.txt"
export __WORDS_RAFT_DIRS="/usr/share/seclists/Discovery/Web-Content/raft-large-words.txt"
export __WORDS_QUICK="/usr/share/seclists/Discovery/Web-Content/quickhits.txt"
export __WORDS_RAFT_FILES="/usr/share/seclists/Discovery/Web-Content/raft-large-files.txt"
export __WORDS_SWAGGER="/usr/share/seclists/Discovery/Web-Content/swagger.txt"

export __EXT_PHP=".php,.phtml,.pht,.xml,.inc,.log,.sql,.cgi"
export __WORDS_PHP_COMMON="/usr/share/seclists/Discovery/Web-Content/Common-PHP-Filenames.txt"
export __WORDS_PHP_FUZZ="/usr/share/seclists/Discovery/Web-Content/PHP.fuzz.txt"

export __PASS_ROCKYOU="/usr/share/wordlists/rockyou.txt"

export __IMPACKET="/usr/share/doc/python3-impacket/examples/"

export __UA_GOOGLEBOT="Googlebot/2.1 (+http://www.google.com/bot.html)"
export __UA_CHROME="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
export __UA_IOS="Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
export __UA=${__UA_CHROME}

############################################################# 
# Helpers
#############################################################

export __IFACES=$(ip addr list | awk -F': ' '/^[0-9]/ {print $2}')
export __STATUS=$(cd ${__PLUGIN} && git status | grep On | cut -d" " -f2,3)

__info() echo "$fg[blue][*] $@ $reset_color"
__ok() echo "$fg[green][+] $@ $reset_color"
__warn() echo "$fg[yellow][>] $@ $reset_color"
__err() echo "$fg[red][!] $@ $reset_color"


############################################################# 
# Self Update
#############################################################

qq-update() {
  cd $HOME/.oh-my-zsh/custom/plugins/quiver
  git pull
  cd - > /dev/null
  source $HOME/.zshrc
}

qq-status() {
  cd $HOME/.oh-my-zsh/custom/plugins/quiver
  git status | grep On | cut -d" " -f2,3
  cd - > /dev/null
}

qq-debug() {
  cat ${__LOGFILE}
}

############################################################# 
# Diagnostic Log
#############################################################

echo "Quiver ${__VER} in ${__PLUGIN}" > ${__LOGFILE}
echo " " >> ${__LOGFILE}
echo "[*] loading... " >> ${__LOGFILE}

#Source all qq scripts

for f in ${0:A:h}/modules/qq-* ; do
  echo "[+] sourcing $f ... "  >> ${__LOGFILE}
  source $f >> ${__LOGFILE} 2>&1
done

echo "[*] quiver loaded." >> ${__LOGFILE}

############################################################# 
# Shell Log
#############################################################

echo " "
echo "$fg[cyan][*] Quiver ${__VER} ZSH plugin loaded. $reset_color"

