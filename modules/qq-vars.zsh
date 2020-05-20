#!/usr/bin/env zsh

############################################################# 
# qq-vars
#############################################################

qq-vars-help() {
  cat << END

qq-vars
-------
The vars namespace manages environment variables used in other functions. These
variables are set per session, but can be saved with qq-vars-save and reloaded
with qq-vars-load. The values are stored as files in .quiver/vars.

Variables
---------
__PROJECT: the root directory used for all output, ex: /projects/example
__LOGBOOK: the logbook.md markdown file used in qq-log commands 
__IFACE: the interface to use for commands, ex: eth0
__DOMAIN: the domain to use for commands, ex: www.example.org
__NETWORK: the subnet to use for commands, ex: 10.1.2.0/24
__RHOST: the remote host or target, ex: 10.1.2.3, example: www.example.org
__RPORT: the remote port; ex: 80
__LHOST: the accessible local IP address, ex: 10.1.2.3
__LPORT: the accessible local PORT, ex: 4444
__URL: a target URL, example: https://www.example.org
__UA: the user agent to use for commands, ex: googlebot
__WORDLIST: path to a wordlist file, ex: /usr/share/wordlists/example.txt
__PASSLIST: path to a wordlist for password brute forcing, ex: /usr/share/wordlists/rockyou.txt

Commands
--------
qq-vars: list all current variable values
qq-vars-save: save all current variable values ($HOME/.quiver)
qq-vars-load: restores all current variable values ($HOME/.quiver)
qq-vars-clear: clears all current variable values
qq-vars-set-*: used to set each individual variable

END
}

qq-vars() {
  echo "$(__cyan __PROJECT: ) ${__PROJECT}"
  echo "$(__cyan __LOGBOOK: ) ${__LOGBOOK}"
  echo "$(__cyan __IFACE: ) ${__IFACE}"
  echo "$(__cyan __DOMAIN: ) ${__DOMAIN}"
  echo "$(__cyan __NETWORK: ) ${__NETWORK}"
  echo "$(__cyan __RHOST: ) ${__RHOST}"
  echo "$(__cyan __RPORT: ) ${__RPORT}"
  echo "$(__cyan __LHOST: ) ${__LHOST}"
  echo "$(__cyan __LPORT: ) ${__LPORT}"
  echo "$(__cyan __URL: ) ${__URL}"
  echo "$(__cyan __UA: ) ${__UA}"
  echo "$(__cyan __WORDLIST: ) ${__WORDLIST}"
  echo "$(__cyan __PASSLIST: ) ${__PASSLIST}"
}

qq-vars-clear() {
  __PROJECT=""
  __LOGBOOK=""
  __IFACE=""
  __DOMAIN=""
  __NETWORK=""
  __RHOST=""
  __RPORT=""
  __LHOST=""
  __LPORT=""
  __URL=""
  __UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
  __WORDLIST=""
  __PASSLIST=""
}

qq-vars-save() {
  echo "${__PROJECT}" > $__VARS/PROJECT
  echo "${__LOGBOOK}" > $__VARS/LOGBOOK
  echo "${__IFACE}" > $__VARS/IFACE
  echo "${__DOMAIN}" > $__VARS/DOMAIN
  echo "${__NETWORK}" > $__VARS/NETWORK
  echo "${__RHOST}" > $__VARS/RHOST
  echo "${__RPORT}" > $__VARS/RPORT
  echo "${__LHOST}" > $__VARS/LHOST
  echo "${__LPORT}" > $__VARS/LPORT
  echo "${__URL}" > $__VARS/URL
  echo "${__UA}" > $__VARS/UA
  echo "${__WORDLIST}" > $__VARS/WORDLIST
  echo "${__PASSLIST}" > $__VARS/PASSLIST
}

qq-vars-load() {
    __PROJECT=$(cat $__VARS/PROJECT) 
    __LOGBOOK=$(cat $__VARS/LOGBOOK)
    __IFACE=$(cat $__VARS/IFACE)
    __DOMAIN=$(cat $__VARS/DOMAIN)
    __NETWORK=$(cat $__VARS/NETWORK)
    __RHOST=$(cat $__VARS/RHOST)
    __RPORT=$(cat $__VARS/RPORT)
    __LHOST=$(cat $__VARS/LHOST)
    __LPORT=$(cat $__VARS/LPORT)
    __URL=$(cat $__VARS/URL)
    __UA=$(cat $__VARS/UA)
    __WORDLIST=$(cat $__VARS/WORDLIST)
    __PASSLIST=$(cat $__VARS/PASSLIST)
    qq-vars
}


export __IFACE=""
export __DOMAIN=""
export __NETWORK=""
export __RHOST=""
export __RPORT=""
export __LHOST=""
export __LPORT=""
export __URL=""
export __UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
export __WORDLIST=""
export __PASSLIST="/usr/share/wordlists/rockyou.txt"

########## __PROJECT

export __PROJECT=""

qq-vars-set-project() {
  __ask "Set the full path to the project root directory where all command output will be directed"
  
  local d=$(rlwrap -S "$(__cyan DIR: )" -P "${__PROJECT}" -e '' -c -o cat)
  [[ "$d" == "~"* ]] && __err "~ not allowed, use the full path" && return

  __PROJECT=$d && mkdir -p ${__PROJECT}
}

__check-project() { [[ -z "${__PROJECT}" ]] && qq-vars-set-project }

########## __LOGBOOK

export __LOGBOOK=""

qq-vars-set-logbook() {
  __ask "Set the full path to the directory of the logbook file (filename not included)."
  
  local d=$(rlwrap -S "$(__cyan DIR: )" -P "$HOME" -e '' -c -o cat)
  [[ "$d" == "~"* ]] && __err "~ not allowed, use the full path" && return

  mkdir -p $d

  __LOGBOOK="${d}/logbook.md"
  
  if [[ -f "${__LOGBOOK}" ]]; then
      __warn "${__LOGBOOK} already exists, set as active log"
  else
      touch ${__LOGBOOK}
      echo "# Logbook" >> ${__LOGBOOK}
      echo " " >> ${__LOGBOOK}
      __ok "${__LOGBOOK} created."
  fi

}

__check-logbook() { [[ -z "${__LOGBOOK}" ]] && qq-vars-set-logbook }

qq-vars-set-iface() {
  if [[ -z "${__IFACE}" ]]
  then
    __ask "Choose an interface: "
    __IFACE=$(__menu-helper $(ip addr list | awk -F': ' '/^[0-9]/ {print $2}')) 
  else
    __IFACE=$(rlwrap -S "$(__cyan __IFACE: )" -P "${__IFACE}" -e '' -o cat)
  fi

}

__check-iface() { [[ -z "${__IFACE}" ]] && qq-vars-set-iface }

qq-vars-set-domain() {
  __DOMAIN=$(rlwrap -S "$(__cyan __DOMAIN: )" -P "${__DOMAIN}" -e '' -o cat)
}

__check-domain() { [[ -z "${__DOMAIN}" ]] && qq-vars-set-domain }

qq-vars-set-network() {
  __NETWORK=$(rlwrap -S "$(__cyan __NETWORK: )" -P "${__NETWORK}" -e '' -o cat)
}

__check-network() { [[ -z "${__NETWORK}" ]] && qq-vars-set-network }

qq-vars-set-rhost() __RHOST=$(rlwrap -S "$(__cyan __RHOST: )" -P "${__RHOST}" -e '' -o cat)

qq-vars-set-rport() __RPORT=$(rlwrap -S "$(__cyan __RPORT: )" -P "${__RPORT}" -e '' -o cat)

qq-vars-set-lhost() {
  if [[ -z $__LHOST ]]
  then
    __ask "Choose a local IP address: " 
    __LHOST=$(__menu-helper $(ip addr list | grep -e "inet " | cut -d' ' -f6 | cut -d'/' -f1))
  else
    __LHOST=$(rlwrap -S "$(__cyan __LHOST: )" -P "${__LHOST}" -e '' -o cat)
  fi
}

qq-vars-set-lport() __LPORT=$(rlwrap -S "$(__cyan __LPORT: )" -P "${__LPORT}" -e '' -o cat)

qq-vars-set-url() __URL=$(rlwrap -S "$(__cyan __URL: )" -P "${__URL}" -e '' -o cat)

qq-vars-set-ua() {
  __ask "Choose a user agent: " 
  __UA=$(__menu-helper \
  "Googlebot/2.1 (+http://www.google.com/bot.html)"\
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"\
  "Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"\
  )
}

__check-ua() { [[ -z "${__UA}" ]] && qq-vars-set-ua }

qq-vars-set-wordlist() {
  if [[ -z $__WORDLIST ]]
  then
    __ask "Choose a wordlist: "
    __WORDLIST=$(__menu-helper \
    "/usr/share/seclists/Discovery/Web-Content/quickhits.txt"\
    "/usr/share/seclists/Discovery/Web-Content/common.txt"\
    "/usr/share/seclists/Discovery/Web-Content/raft-large-words.txt"\
    "/usr/share/seclists/Discovery/Web-Content/raft-large-files.txt"\
    "/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"\
    "/usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt"\
    "/usr/share/seclists/Discovery/Web-Content/swagger.txt"\
    "/usr/share/seclists/Discovery/Web-Content/graphql.txt"\
    )
  else
    __WORDLIST=$(rlwrap -S "$(__cyan __WORDLIST: )" -P "${__WORDLIST}" -e '' -o cat)
  fi
}

qq-vars-set-wordlist-web() {
  __ask "Choose a wordlist: "
  __WORDLIST=$(__menu-helper $(find  /usr/share/seclists/Discovery/Web-Content | sort))
}

qq-vars-set-wordlist-dns() {
  __ask "Choose a wordlist: "
  __WORDLIST=$(__menu-helper $(find  /usr/share/seclists/Discovery/DNS | sort))
}

qq-vars-set-passlist() {
  __ask "Choose a passlist: "
  __PASSLIST=$(__menu-helper $(find  /usr/share/seclists/Passwords | sort))
}


# helpers

__netpath() { 
  __check-project
  local net=$(echo ${__NETWORK} | cut -d'/' -f1)
  local result=${__PROJECT}/networks/${net}
  mkdir -p "${result}"
  echo  "${result}"
}

__hostpath() { 
  __check-project
  local result=${__PROJECT}/hosts/${__RHOST}
  mkdir -p "${result}"
  echo  "${result}"
}

__urlpath() { 
  __check-project
  local host=$(echo ${__URL} | cut -d'/' -f3)
  local result=${__PROJECT}/hosts/${host}
  mkdir -p "${result}"
  echo  "${result}"
}

__dompath() { 
  __check-project
  local result=${__PROJECT}/domains/${__DOMAIN}
  mkdir -p "${result}"
  echo  "${result}"
}

__rand() {
    if [ "$#" -eq  "1" ]
    then
        head /dev/urandom | tr -dc A-Za-z0-9 | head -c $1 ; echo ''
    else
        head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ; echo ''
    fi  
}

__menu-helper() {
  PS3="$fg[cyan]Select:$reset_color "
  COLUMNS=6
  select o in $@; do break; done
  echo ${o}
}
