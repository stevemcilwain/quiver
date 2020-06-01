#!/usr/bin/env zsh

############################################################# 
# qq
#############################################################

qq-help() {
    cat << "DOC"

qq
--
The qq namespace is the root of all other namespaces that can be access with tab-completion.
To get started, explore the qq-<namespace>-help commands. Install dependencies per namespace,
using the qq-<namespace>-install commands or install all dependencies using qq-install-all.

Variables
---------
__VERSION     Current version of the Quiver plugin
__PLUGIN      Full path to the Quiver oh-my-zsh plugin directory

Commands
--------
qq-update:        git pull the latest (MASTER branch) version of Quiver
qq-status:        check the current status of the locally cloned Quiver repository
qq-whatsnew:      display the latest release notes
qq-debug:         display the local diagnostic log

Namespaces
----------
Quiver is organized in a tree of namespaces that are accessible via "qq-" with tab completion and search.
Each namespace has its own install and help commands.

 Install and Configuration
 -------------------------
 qq-vars-global-     Persistent environment variables used in all commands, all sessions
 qq-install-         Installers for commonly used applications and global installer for all dependencies
 qq-notes-           Configure and read your markdown notes

 Utility
 ---------
 qq-encoding-      Used for encoding / decoding data
 qq-kali-          Variety of commands for managing Kali linux

 Engagement / Project / Bounty
 -----------------------------
 qq-log-         Configure and setup a logbook for current engagement
 qq-vars-        Per-session, per-engagement variables used in all commands
 qq-bounty-      Commands to assist in generating bug bounty scope files and data sync helpers
 qq-project-     Commands for custom project directory scaffolding (expirimental)

 Recon Phase
 -----------
 qq-recon-org-          Recon commands for organization files and data
 qq-recon-github-       Recon commands for searching github repositories
 qq-recon-networks-     Recon commands for identiying an organization's networks
 qq-recon-domains-      Recon commands for horizontal domain enumeration
 qq-recon-subs-         Recon commands for vertical sub-domain enumeration 

 Active Enumeration Phase
 ------------------------
 qq-enum-network-         Enumerate and scan networks
 qq-enum-host-            Enumerate and scan an individual host
 qq-enum-dhcp-            Enumerate DHCP services
 qq-enum-dns-             Enumerate DNS services
 qq-enum-ftp-             Enumerate FTP services
 qq-enum-kerb-            Enumerate Kerberos services
 qq-enum-ldap-            Enumerate LDAP and Active Directory services
 qq-enum-mssql-           Enumerate MSSQL database services
 qq-enum-mysql-           Enumerate MYSQL database services
 qq-enum-nfs-             Enumerate NFS shares and services
 qq-enum-oracle-          Enumerate Oracle database services
 qq-enum-pop3-            Enumerate POP3 services
 qq-enum-rdp-             Enumerate RDP services
 qq-enum-smb-             Enumerate SMB services
 qq-enum-web-             Enumerate web servers and services
 qq-enum-web-aws-         Enumerate AWS hosted services
 qq-enum-web-dirs-        Enumerate directories and files
 qq-enum-web-elastic-     Enumerate elastic search services
 qq-enum-web-fuzz-        Fuzz inputs such as forms, cookies and headers
 qq-enum-web-js-          Mine javascript files for secrets
 qq-enum-web-php-         Enumerate php web servers
 qq-enum-web-ssl-         Enumerate SSL certs and services
 qq-enum-web-vuln-        Check for common web vulnerabilities
 qq-enum-web-xss-         XSS helpers

 Exploitation Phase
 ------------------
 qq-srv-                     Commands for spawning file hosting services
 qq-exploit-                 Commands for compiling exploits
 qq-shell-tty-               Commands for upgrading shells to tty
 qq-shell-handlers-          Commands for spawning reverse shell handlers
 qq-shell-handlers-msf-      Commands for spawning reverse shells with Metasploit
  
 Post-Exploitation Phase
 -----------------------
 qq-pivot-     Commands for pivoting with ssh

DOC
}

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

##### Output Helpers

__cyan() echo "$fg[cyan]$@ $reset_color"
__green() echo "$fg[green]$@ $reset_color"
__blue() echo "$fg[blue]$@ $reset_color"
__yellow() echo "$fg[yellow]$@ $reset_color"
__err() echo "$fg[red]$@ $reset_color"

__info() __blue "[*] $@"
__ok() __green "[+] $@"
__warn() __yellow "[!] $@"
__err() __red "[X] $@"

##### Input Helpers

__ask() __yellow "$@"
__prompt() __cyan "[?] $@"

__askvar() { 
    local retval=$1
    local question=$2
    local tmpval
    read "tmpval?$fg[cyan]${question}:$reset_color "
    eval $retval="'$tmpval'"
}

__askpath() { 
    local retval=$1
    local question=$2
    local prefill=$3
    local tmpinput=$(rlwrap -S "$fg[cyan]${question}: $reset_color" -P "${prefill}" -e '' -c -o cat)
    local tmpval=$(echo "${tmpinput}" | sed 's/\/$//' )
    eval $retval="'$tmpval'"
}

__prefill() { 
    local retval=$1
    local question=$2
    local prefill=$3
    local tmpval=$(rlwrap -S "$fg[cyan]${question}: $reset_color" -P "${prefill}" -e '' -o cat)
    eval $retval="'$tmpval'"
}

__check-proceed() {
    PS3="$fg[cyan]Select: $reset_color"
    COLUMNS=10
    select yn in "Yes" "Cancel"; do
    case $yn in
        Yes) 
            return 0
            break;;
        *)
            return 1
            break;;
    esac
    done
}

__menu() {
    PS3="$fg[cyan]Select: $reset_color"
    COLUMNS=10
    select o in $@; do break; done
    echo ${o}
}

##### String Helpers

__trim-slash() { echo $1 | sed 's/\/$//' }
__trim-quotes() { echo $1 | tr -d \" }
__trim-newline() { echo $1 | tr -d "\n"}

__rand() {
    if [ "$#" -eq  "1" ]
    then
        head /dev/urandom | tr -dc A-Za-z0-9 | head -c $1 ; echo ''
    else
        head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ; echo ''
    fi  
}

##### Tool Helpers

__msf() {
    local msfcmd=$(cat $@)
    print -z "msfconsole -n -q -x \"${msfcmd}\" "
}