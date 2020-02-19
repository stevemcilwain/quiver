#!/usr/bin/env zsh

############################################################# 
# quiver
# Author: Steve Mcilwain
# Contributors: 
#############################################################
__VER=0.7.0

cat << END
$fg[cyan]

 ____ ____ ____ ____ ____ ____ 
||q |||u |||i |||v |||e |||r ||
||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|

 ${__VER}
$reset_color
END

echo " "
echo "$fg[cyan][*] loading...$reset_color"

autoload colors; colors

#Source all qq scripts

for f in ${0:A:h}/modules/qq-* ; do
  echo "[+] sourcing $f ... "
  source $f;
done

############################################################# 
# Output Helpers
#############################################################

__info() echo "$fg[blue][*] $1$reset_color"
__ok()   echo "$fg[green][+] $1$reset_color"
__warn() echo "$fg[yellow][>] $1$reset_color"
__err()  echo "$fg[red][!] $1$reset_color"

############################################################# 
# Constants
#############################################################

export __NOTES="${0:A:h}/notes"
export __SCRIPTS="${0:A:h}/scripts"

export __WORDS_ALL="/opt/words/all/all.txt"
export __WORDS_NULL="/opt/words/nullenc/null.txt"
export __WORDS_COMMON="/usr/share/seclists/Discovery/Web-Content/common.txt"
export __WORDS_RAFT_DIRS="/usr/share/seclists/Discovery/Web-Content/raft-large-words.txt"
export __WORDS_QUICK="/usr/share/seclists/Discovery/Web-Content/quickhits.txt"
export __WORDS_MEDIUM="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
export __WORDS_RAFT_FILES="/usr/share/seclists/Discovery/Web-Content/raft-large-files.txt"
export __WORDS_SWAGGER="/usr/share/seclists/Discovery/Web-Content/swagger.txt"

export __PASS_ROCKYOU="/usr/share/wordlists/rockyou.txt"

export __UA_GOOGLEBOT="Googlebot/2.1 (+http://www.google.com/bot.html)"
export __UA_CHROME="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
export __UA_IOS="Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
export __UA=${__UA_CHROME}

############################################################# 
# Runtime Helpers
#############################################################

export __IFACES=$(ip addr list | awk -F': ' '/^[0-9]/ {print $2}')

############################################################# 
# Update
#############################################################

qq-update() {
  cd ~/.oh-my-zsh/custom/plugins/quiver
  git pull
  cd -
  source ~/.zshrc
}

echo "$fg[cyan][*] quiver loaded.$reset_color"
echo " "
