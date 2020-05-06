#!/usr/bin/env zsh

############################################################# 
# qq-vars
#############################################################

qq-vars-help() {
  cat << END

qq-vars
-------
The vars namespace manages environment variables used in other functions.

Variables
---------
__OUTPUT: the root directory used for all output, ex: /projects/example
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

export __OUTPUT=""
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

# hard coded

export __EXT_PHP=".php,.phtml,.pht,.xml,.inc,.log,.sql,.cgi"
export __IMPACKET="/usr/share/doc/python3-impacket/examples/"

# set

qq-vars-set-output() {
  local relative=$(rlwrap -S "$(__cyan __OUTPUT: )" -P "${__OUTPUT}" -e '' -c -o cat)

  # validate that ~ is not used
  [[ "$relative" == "~"* ]] && __warn "~ not allowed, use the full path" && return

  # get the full path
  __OUTPUT=$(__abspath $relative)
  [[ -z "${__OUTPUT}" ]] && __OUTPUT=$relative

  # if the directory doesn't exist, create it
  if [[ ! -d ${__OUTPUT} ]]
  then
    mkdir -p ${__OUTPUT}
  fi
}

qq-vars-set-iface() {
  if [[ -z "${__IFACE}" ]]
  then
    __ask "Choose an interface: "
    __IFACE=$(__menu-helper $(ip addr list | awk -F': ' '/^[0-9]/ {print $2}')) 
  else
    __IFACE=$(rlwrap -S "$(__cyan __IFACE: )" -P "${__IFACE}" -e '' -o cat)
  fi  
}

qq-vars-set-domain() __DOMAIN=$(rlwrap -S "$(__cyan __DOMAIN: )" -P "${__DOMAIN}" -e '' -o cat)

qq-vars-set-network() __NETWORK=$(rlwrap -S "$(__cyan __NETWORK: )" -P "${__NETWORK}" -e '' -o cat)

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
    "/opt/words/nullenc/null.txt"\
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

# all settings

qq-vars-clear() {
  __OUTPUT=""
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

qq-vars() {
  echo "$(__cyan __OUTPUT: ) ${__OUTPUT}"
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

qq-vars-save() {
  local vars="$HOME/.quiver/vars"
  mkdir -p $vars

  echo "${__OUTPUT}" > $vars/OUTPUT
  echo "${__IFACE}" > $vars/IFACE
  echo "${__DOMAIN}" > $vars/DOMAIN
  echo "${__NETWORK}" > $vars/NETWORK
  echo "${__RHOST}" > $vars/RHOST
  echo "${__RPORT}" > $vars/RPORT
  echo "${__LHOST}" > $vars/LHOST
  echo "${__LPORT}" > $vars/LPORT
  echo "${__URL}" > $vars/URL
  echo "${__UA}" > $vars/UA
  echo "${__WORDLIST}" > $vars/WORDLIST
  echo "${__PASSLIST}" > $vars/PASSLIST
}

qq-vars-load() {
    local vars="$HOME/.quiver/vars"
    __OUTPUT=$(cat $vars/OUTPUT) 
    __IFACE=$(cat $vars/IFACE)
    __DOMAIN=$(cat $vars/DOMAIN)
    __NETWORK=$(cat $vars/NETWORK)
    __RHOST=$(cat $vars/RHOST)
    __RPORT=$(cat $vars/RPORT)
    __LHOST=$(cat $vars/LHOST)
    __LPORT=$(cat $vars/LPORT)
    __URL=$(cat $vars/URL)
    __UA=$(cat $vars/UA)
    __WORDLIST=$(cat $vars/WORDLIST)
    __PASSLIST=$(cat $vars/PASSLIST)
    qq-vars
}

# helpers

__abspath() {
    # Thanks to: https://stackoverflow.com/questions/3915040/bash-fish-command-to-print-absolute-path-to-a-file/23002317#23002317
    # generate absolute path from relative path
    # $1     : relative filename
    # return : absolute path

    if [ -d "$1" ]; then
        # dir
        (cd "$1"; pwd)
    elif [ -f "$1" ]; then
        # file
        if [[ $1 = /* ]]; then
            echo "$1"
        elif [[ $1 == */* ]]; then
            echo "$(cd "${1%/*}"; pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}

__netpath() { 
  qq-vars-set-output
  local net=$(echo ${__NETWORK} | cut -d'/' -f1)
  local result=${__OUTPUT}/networks/${net}
  mkdir -p "${result}"
  echo  "${result}"
}

__hostpath() { 
  qq-vars-set-output
  local result=${__OUTPUT}/hosts/${__RHOST}
  mkdir -p "${result}"
  echo  "${result}"
}

__urlpath() { 
  qq-vars-set-output
  local host=$(echo ${__URL} | cut -d'/' -f3)
  local result=${__OUTPUT}/hosts/${host}
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
