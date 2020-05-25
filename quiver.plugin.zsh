#!/usr/bin/env zsh

autoload colors; colors

############################################################# 
# quiver
# Author: Steve Mcilwain
# Contributors: 
#############################################################

# check for essential packages

dpkg -l | grep -qw rlwrap || sudo apt-get -y install rlwrap
dpkg -l | grep -qw rlwrap || sudo apt-get -y install git

# check for directories

mkdir -p $HOME/.quiver/{vars,globals}

############################################################# 
# Constants
#############################################################

export __PLUGIN="${0:A:h}"
export __VER=$(cat ${__PLUGIN}/VERSION)
export __LOGFILE="${__PLUGIN}/log.txt"
export __REMOTE_CHK="${__PLUGIN}/remote_checked.txt"
export __REMOTE_VER="${__PLUGIN}/remote_ver.txt"
export __STATUS=$(cd ${__PLUGIN} && git status | grep On | cut -d" " -f2,3)
export __VARS=$HOME/.quiver/vars
export __GLOBALS=$HOME/.quiver/globals
export __PAYLOADS="$__PLUGIN/payloads"
export __SCRIPTS="$__PLUGIN/scripts"
export __TOOLS="$HOME/tools"

############################################################# 
# Self Update
#############################################################

__version-check() {

  local seconds=$((60*60*24*1))

  if test -f "$__REMOTE_CHK" ; then
      if test "$(($(date "+%s")-$(date -f "$__REMOTE_CHK" "+%s")))" -lt "$seconds" ; then
            echo "[*] Version already checked today: $__REMOTE_CHK" >> ${__LOGFILE}
          exit 1
      fi
  fi

  date -R > $__REMOTE_CHK

  echo "$(curl -s https://raw.githubusercontent.com/stevemcilwain/quiver/master/VERSION)" > $__REMOTE_VER
  
  echo "[*] Version checked and stored in:  $__REMOTE_VER" >> ${__LOGFILE}

}

(__version-check &)

############################################################# 
# Diagnostic Log
#############################################################

echo "Quiver ${__VER} in ${__PLUGIN}" > ${__LOGFILE}
echo " " >> ${__LOGFILE}
echo "[*] loading... " >> ${__LOGFILE}

#Source all qq scripts

for f in ${0:A:h}/modules/qq* ; do
  echo "[+] sourcing $f ... "  >> ${__LOGFILE}
  source $f >> ${__LOGFILE} 2>&1
done

# completion enhancement
# zstyle ':completion:*' matcher-list 'r:|[-]=**'
ZSTYLE_ORIG=`zstyle -L ':completion:\*' matcher-list`
ZSTYLE_NEW="${ZSTYLE_ORIG} 'r:|[-]=**'"
eval ${ZSTYLE_NEW}

echo "[*] quiver loaded." >> ${__LOGFILE}

############################################################# 
# Shell Log
#############################################################

echo " "

if [[ -f "$__REMOTE_VER" ]]; then
  
  echo "[*] Remote version file exists: $__REMOTE_VER " >> ${__LOGFILE}

  rv=$(cat ${__REMOTE_VER})

  if [[ ! -z $rv ]]; then

    echo "[*] Remote version is |${rv}|" >> ${__LOGFILE}

    [[ "$rv" == "$__VER" ]] && __info "Quiver is up to date" || __warn "Quiver update available: $rv, use qq-update to install"

  fi

fi

__info "Quiver ${__VER} ZSH plugin loaded "

