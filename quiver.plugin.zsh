#!/usr/bin/env zsh

autoload colors; colors

############################################################# 
# quiver
# Author: Steve Mcilwain
# Contributors: 
#############################################################

############################################################# 
# Constants
#############################################################

export __PLUGIN="${0:A:h}"
export __VER=$(cat ${__PLUGIN}/VERSION)
export __LOGFILE="${__PLUGIN}/log.txt"
export __REMOTE_CHK="${__PLUGIN}/remote_checked.txt"
export __REMOTE_VER="${__PLUGIN}/remote_ver.txt"


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
__cyan() echo "$fg[cyan]$@ $reset_color"


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

qq-update() {
  cd $HOME/.oh-my-zsh/custom/plugins/quiver
  git pull
  rm $__REMOTE_VER
  rm $__REMOTE_CHK
  cd - > /dev/null
  source $HOME/.zshrc
}

qq-status() {
  cd $HOME/.oh-my-zsh/custom/plugins/quiver
  git status | grep On | cut -d" " -f2,3
  cd - > /dev/null
}

qq-whatsnew() {
  cat $__PLUGIN/RELEASES.md
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

# check for essential packages

dpkg -l | grep -qw rlwrap || sudo apt-get -y install rlwrap

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

