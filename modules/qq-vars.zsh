#!/usr/bin/env zsh

############################################################# 
# qq-vars
#############################################################

export __OUTPUT=""
export __IFACE=""
export __DOMAIN=""
export __NETWORK=""
export __RHOST=""
export __LHOST=""
export __URL=""
export __UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
export __WORDLIST=""
export __PASSLIST="/usr/share/wordlists/rockyou.txt"

# hard coded

export __EXT_PHP=".php,.phtml,.pht,.xml,.inc,.log,.sql,.cgi"
export __IMPACKET="/usr/share/doc/python3-impacket/examples/"

# set

qq-vars-set-domain() __DOMAIN=$(rlwrap -S "$fg[cyan]DOMAIN: $reset_color" -P "${__DOMAIN}" -e '' -o cat)
alias var-domain="qq-vars-set-domain"

qq-vars-set-network() __NETWORK=$(rlwrap -S "$fg[cyan]NETWORK: $reset_color" -P "${__NETWORK}" -e '' -o cat)
alias var-network="qq-vars-set-network"

qq-vars-set-rhost() __RHOST=$(rlwrap -S "$fg[cyan]RHOST: $reset_color" -P "${__RHOST}" -e '' -o cat)
alias var-rhost="qq-vars-set-rhost"

qq-vars-set-url() __URL=$(rlwrap -S "$fg[cyan]URL: $reset_color" -P "${__URL}" -e '' -o cat)
alias var-url="qq-vars-set-url"

qq-vars-set-output() {
  local relative=$(rlwrap -S "$fg[cyan]OUTPUT: $reset_color" -P "${__OUTPUT}" -e '' -c -o cat)
  
  [[ "$relative" == *"~"* ]] && __warn "~ not allowed" && return

  __OUTPUT=$(__abspath $relative)
 
  mkdir -p ${__OUTPUT}/burp
  mkdir -p ${__OUTPUT}/target
  mkdir -p ${__OUTPUT}/domains
  mkdir -p ${__OUTPUT}/networks
  mkdir -p ${__OUTPUT}/hosts
  mkdir -p ${__OUTPUT}/files/{downloads,uploads}
  mkdir -p ${__OUTPUT}/notes/screenshots
  mkdir -p ${__OUTPUT}/data

}
alias var-out="qq-vars-set-output"

qq-vars-set-wordlist() {
    [[ -z $__WORDLIST ]] && __ask "Choose a wordlist: " && __menu-wordlist-fav && return
    __WORDLIST=$(rlwrap -S "$fg[cyan]WORDLIST: $reset_color" -P "${__WORDLIST}" -e '' -o cat)
}
alias var-words="qq-vars-set-wordlist"

qq-vars-set-lhost() {
    [[ -z $__LHOST ]] && __ask "Choose a local IP address: " && __menu-lhost && return
    __LHOST=$(rlwrap -S "$fg[cyan]LHOST: $reset_color" -P "${__LHOST}" -e '' -o cat)
}
alias var-lhost="qq-vars-set-lhost"

qq-vars-set-iface() {
    [[ -z $__IFACE ]] && __ask "Choose an interface: " && __menu-iface && return
    __IFACE=$(rlwrap -S "$fg[cyan]IFACE: $reset_color" -P "${__IFACE}" -e '' -o cat)
}
alias var-iface="qq-vars-set-iface"

# all settings

qq-vars-clear() {
    __OUTPUT=""
    __IFACE=""
    __DOMAIN=""
    __NETWORK=""
    __RHOST=""
    __LHOST=""
    __URL=""
    __UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
    __WORDLIST=""
    __PASSLIST=""
}
alias varcls="qq-vars-clear"

qq-vars() {
    echo "$fg[cyan] __OUTPUT:$reset_color ${__OUTPUT}"
    echo "$fg[cyan] __IFACE:$reset_color ${__IFACE}"
    echo "$fg[cyan] __DOMAIN:$reset_color ${__DOMAIN}"
    echo "$fg[cyan] __NETWORK:$reset_color ${__NETWORK}"
    echo "$fg[cyan] __RHOST:$reset_color ${__RHOST}"
    echo "$fg[cyan] __LHOST:$reset_color ${__LHOST}"
    echo "$fg[cyan] __URL:$reset_color ${__URL}"
    echo "$fg[cyan] __WORDLIST:$reset_color ${__WORDLIST}"
    echo "$fg[cyan] __PASSLIST:$reset_color ${__PASSLIST}"
}
alias var="qq-vars"

qq-vars-save() {
    local vars="$HOME/.quiver/vars"
    mkdir -p $vars

    echo "${__OUTPUT}" > $vars/OUTPUT
    echo "${__IFACE}" > $vars/IFACE
    echo "${__DOMAIN}" > $vars/DOMAIN
    echo "${__NETWORK}" > $vars/NETWORK
    echo "${__RHOST}" > $vars/RHOST
    echo "${__LHOST}" > $vars/LHOST
    echo "${__URL}" > $vars/URL
    echo "${__UA}" > $vars/UA
    echo "${__WORDLIST}" > $vars/WORDLIST
    echo "${__PASSLIST}" > $vars/PASSLIST
}
alias varsav="qq-vars-save"

qq-vars-load() {
    local vars="$HOME/.quiver/vars"
    __OUTPUT=$(cat $vars/OUTPUT) 
    __IFACE=$(cat $vars/IFACE)
    __DOMAIN=$(cat $vars/DOMAIN)
    __NETWORK=$(cat $vars/NETWORK)
    __RHOST=$(cat $vars/RHOST)
    __LHOST=$(cat $vars/LHOST)
    __URL=$(cat $vars/URL)
    __UA=$(cat $vars/UA)
    __WORDLIST=$(cat $vars/WORDLIST)
    __PASSLIST=$(cat $vars/PASSLIST)
    qq-vars-print
}
alias varload="qq-vars-load"

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

__menu-helper() {
  PS3="$fg[cyan][#]:$reset_color "
  COLUMNS=6
  select o in $@; do break; done
  echo ${o}
}

__menu-ua() {
  __UA=$(__menu-helper \
  "Googlebot/2.1 (+http://www.google.com/bot.html)"\
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"\
  "Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"\
  )
}

__menu-iface() {
  __IFACE=$(__menu-helper $(ip addr list | awk -F': ' '/^[0-9]/ {print $2}'))
}

__menu-lhost() {
  __LHOST=$(__menu-helper $(ip addr list | grep -e "inet " | cut -d' ' -f6 | cut -d'/' -f1))
}

__menu-wordlist-fav() {
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

__menu-wordlist-web() {
  __WORDLIST=$(__menu-helper $(find  /usr/share/seclists/Discovery/Web-Content | sort))
}

