#!/usr/bin/env zsh

############################################################# 
# qq-vars
#############################################################

qq-vars-help() {
  cat << "DOC"

qq-vars
-------
The vars namespace manages environment variables used in other functions. These
variables are set per session, but can be saved with qq-vars-save and reloaded
with qq-vars-load. The values are stored as files in .quiver/vars.

The menu options for some of the variables can be set using qq-vars-global, such
as the list of favorite user-agents or wordlists (qq-vars-global-help).

Variables
---------
__PROJECT:     the root directory used for all output, ex: /projects/example
__LOGBOOK:     the logbook.md markdown file used in qq-log commands 
__IFACE:       the interface to use for commands, ex: eth0
__DOMAIN:      the domain to use for commands, ex: example.org
__NETWORK:     the subnet to use for commands, ex: 10.1.2.0/24
__RHOST:       the remote host or target, ex: 10.1.2.3, example: target.example.org
__RPORT:       the remote port; ex: 80
__LHOST:       the accessible local IP address, ex: 10.1.2.3
__LPORT:       the accessible local PORT, ex: 4444
__URL:         a target URL, example: https://target.example.org
__UA:          the user agent to use for commands, ex: googlebot
__WORDLIST:    path to a wordlist file, ex: /usr/share/wordlists/example.txt
__PASSLIST:    path to a wordlist for password brute forcing, ex: /usr/share/wordlists/rockyou.txt

Commands
--------
qq-vars:           alias qv, list all current variable values
qq-vars-save:      alias qvs, save all current variable values ($HOME/.quiver)
qq-vars-load:      alias qvl, restores all current variable values ($HOME/.quiver)
qq-vars-clear:     clears all current variable values
qq-vars-set-*:     used to set each individual variable

DOC
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
alias qv="qq-vars"

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
  qq-vars
}
alias qvs="qq-vars-save"

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
alias qvl="qq-vars-load"


########## __PROJECT

export __PROJECT=""

qq-vars-set-project() {
  __ask "Set the full path to the project root directory where all command output will be directed"
  
  local d && __askpath d "PROJECT DIR" ${__PROJECT}
  [[ "$d" == "~"* ]] && __err "~ not allowed, use the full path" && return

  __PROJECT=$d
  mkdir -p ${__PROJECT}
  
}

__check-project() { [[ -z "${__PROJECT}" ]] && qq-vars-set-project }

########## __LOGBOOK

export __LOGBOOK=""

qq-vars-set-logbook() {
  __ask "Set the full path to the directory of the logbook file (filename not included)."
  
  local d=$(__askpath DIR $HOME)
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

########## __IFACE

export __IFACE=""

qq-vars-set-iface() {
  if [[ -z "${__IFACE}" ]]
  then
    __ask "Choose an interface: "
    __IFACE=$(__menu $(ip addr list | awk -F': ' '/^[0-9]/ {print $2}')) 
  else
    __prefill __IFACE IFACE ${__IFACE}
  fi

}

__check-iface() { [[ -z "${__IFACE}" ]] && qq-vars-set-iface }

########## __DOMAIN

export __DOMAIN=""

qq-vars-set-domain() { __prefill __DOMAIN DOMAIN ${__DOMAIN} }

__check-domain() { [[ -z "${__DOMAIN}" ]] && qq-vars-set-domain }


########## __NETWORK

export __NETWORK=""

qq-vars-set-network() { __prefill __NETWORK NETWORK ${__NETWORK} }

__check-network() { [[ -z "${__NETWORK}" ]] && qq-vars-set-network }

########## __RHOST

export __RHOST=""

qq-vars-set-rhost() { __prefill __RHOST RHOST ${__RHOST} }

########## __RPORT

export __RPORT=""

qq-vars-set-rport() { __prefill __RPORT RPORT ${__RPORT} }

########## __LHOST

export __LHOST=""

qq-vars-set-lhost() {
  if [[ -z $__LHOST ]]
  then
    __ask "Choose a local IP address: " 
    __LHOST=$(__menu $(ip addr list | grep -e "inet " | cut -d' ' -f6 | cut -d'/' -f1))
  else
    __prefill __LHOST LHOST ${__LHOST}
  fi
}

########## __LPORT

export __LPORT=""

qq-vars-set-lport() { __prefill __LPORT LPORT ${__LPORT} }


########## __URL

export __URL=""

qq-vars-set-url() { 
  local u && __prefill u URL ${__URL}
  __URL=$(echo ${u} | sed 's/\/$//')
}

########## __UA

export __UA="Mozilla/5.0"

qq-vars-set-ua() {
  IFS=$'\n'
  __ask "Choose a user agent: " 
  __UA=$(__menu $(cat  ${__MNU_UA}))
}

__check-ua() { [[ -z "${__UA}" ]] && qq-vars-set-ua }

########## __WORDLIST

export __WORDLIST=""

qq-vars-set-wordlist() {
  if [[ -z $__WORDLIST ]]
  then
    __ask "Choose a wordlist: "
    __WORDLIST=$(__menu $(cat  ${__MNU_WORDLISTS}))
  else

    __WORDLIST= __prefill __WORDLIST WORDLIST ${__WORDLIST}
  fi
}

qq-vars-set-wordlist-web() {
  __ask "Choose a wordlist: "
  __WORDLIST=$(__menu $(find  /usr/share/seclists/Discovery/Web-Content | sort))
}

qq-vars-set-wordlist-dns() {
  __ask "Choose a wordlist: "
  __WORDLIST=$(__menu $(find  /usr/share/seclists/Discovery/DNS | sort))
}

########## __PASSLIST

export __PASSLIST="/usr/share/wordlists/rockyou.txt"

qq-vars-set-passlist() {
  __ask "Choose a passlist: "
  __PASSLIST=$(__menu $(find  /usr/share/seclists/Passwords | sort))
}


# helpers

export __THREADS
__check-threads() { __askvar __THREADS THREADS }

export __USER
__check-user() { __askvar __USER USER }

export __SHARE
__check-share() { __askvar __SHARE SHARE }

export __ORG
__check-org() { __askvar __ORG ORG }

export __ASN
__check-asn() { __askvar __ASN ASN }


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

