#!/usr/bin/env zsh

autoload colors; colors

############################################################# 
# quiver
# Author: Steve Mcilwain
# Contributors: 
#############################################################

export __VER=0.12

############################################################# 
# Constants
#############################################################

export __PLUGIN="${0:A:h}"
export __LOGFILE="${__PLUGIN}/log.txt"
export __SCRIPTS="${0:A:h}/scripts"

# These are current values used by all functions

export __OUTPUT="./"
export __IFACE=""
export __DOMAIN=""
export __NETWORK=""
export __RHOST=""
export __LHOST=""
export __URL=""
export __UA=${__UA_CHROME}
export __WORDLIST=""
export __PASSLIST=""


__GET-IFACE() __IFACE=$(rlwrap -S 'IFACE: ' -P "${__IFACE}" -e '' -o cat)
__GET-DOMAIN() __DOMAIN=$(rlwrap -S 'DOMAIN: ' -P "${__DOMAIN}" -e '' -o cat)
__GET-NETWORK() __NETWORK=$(rlwrap -S 'NETWORK: ' -P "${__NETWORK}" -e '' -o cat)
__GET-RHOST() __RHOST=$(rlwrap -S 'RHOST: ' -P "${__RHOST}" -e '' -o cat)
__GET-LHOST() __LHOST=$(rlwrap -S 'LHOST: ' -P "${__LHOST}" -e '' -o cat)
__GET-URL() __URL=$(rlwrap -S 'URL: ' -P "${__URL}" -e '' -o cat)
__GET-WORDLIST() __WORDLIST=$(rlwrap -S 'WORDLIST: ' -P "${__WORDLIST}" -e '' -o cat)


__CLEAR() {
  __IFACE=""
  __DOMAIN=""
  __NETWORK=""
  __RHOST=""
  __LHOST=""
  __URL=""
  __UA=${__UA_CHROME}
  __WORDLIST=""
  __PASSLIST=""
}

__menu-helper() {
  PS3="Choose: "
  select o in $@; do break; done
  echo ${o}
}

__SET-UA() {
  __UA=$(__menu-helper \
  "Googlebot/2.1 (+http://www.google.com/bot.html)"\
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"\
  "Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"\
  )
}

__SET-IFACES() {
  __IFACE=$(__menu-helper $(ip addr list | awk -F': ' '/^[0-9]/ {print $2}'))
}

__SET-WORDLIST_FAV() {
  __WORDLIST=$(__menu-helper \
  "/usr/share/seclists/Discovery/Web-Content/quickhits.txt"\
  "/usr/share/seclists/Discovery/Web-Content/common.txt"\
  "/usr/share/seclists/Discovery/Web-Content/raft-large-words.txt"\
  "/usr/share/seclists/Discovery/Web-Content/raft-large-files.txt"\
  "/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"\
  "/opt/words/all/all.txt"\
  "/opt/words/nullenc/null.txt"\
  "/usr/share/seclists/Discovery/Web-Content/swagger.txt"\
  "/usr/share/seclists/Discovery/Web-Content/graphql.txt"\
  )
}

__SET-WORDLIST_WEB-CONTENT() {
  __WORDLIST=$(__menu-helper $(find  /usr/share/seclists/Discovery/Web-Content | sort))
}

export __EXT_PHP=".php,.phtml,.pht,.xml,.inc,.log,.sql,.cgi"
export __PASS_ROCKYOU="/usr/share/wordlists/rockyou.txt"
export __IMPACKET="/usr/share/doc/python3-impacket/examples/"

############################################################# 
# Helpers
#############################################################

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

