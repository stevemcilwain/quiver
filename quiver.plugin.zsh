#!/usr/bin/env zsh

autoload colors; colors

############################################################# 
# quiver
# Author: Steve Mcilwain
# Contributors: 
#############################################################

export __VER=0.12.1

############################################################# 
# Constants
#############################################################

export __PLUGIN="${0:A:h}"
export __LOGFILE="${__PLUGIN}/log.txt"
export __SCRIPTS="${0:A:h}/scripts"

############################################################# 
# Helpers
#############################################################

export __STATUS=$(cd ${__PLUGIN} && git status | grep On | cut -d" " -f2,3)

__info() echo "$fg[cyan][*]$reset_color $@"
__ok() echo "$fg[blue][+]$reset_color $@"
__warn() echo "$fg[yellow][>]$reset_color $@"
__err() echo "$fg[red][!]$reset_color $@ "

__ask() echo "$fg[cyan]$@ $reset_color"
__prompt() echo "$fg[cyan][?] $@ $reset_color"


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

# completion enhancement
# zstyle ':completion:*' matcher-list 'r:|[-]=**'

echo "[*] quiver loaded." >> ${__LOGFILE}

############################################################# 
# Shell Log
#############################################################

echo " "
echo "$fg[cyan][*] Quiver ${__VER} ZSH plugin loaded: $reset_color"

