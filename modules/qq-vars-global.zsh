#!/usr/bin/env zsh

############################################################# 
# qq-vars-global
#############################################################

qq-vars-global-help() {
  cat << END

qq-vars-global
--------------
The vars global namespace manages environment variables used in other functions
that are saved between sessions.  Values are stored as files the .quiver/globals
directory and can contain sensitive information like API keys. These variables
are used to supply arguments to commands in other modules.

Variables
---------
__IMPACKET: full path to the python3 impacket examples directory
__EXT_PHP: a list of file extensions used on PHP webservers
__EXT_DOCS: a list of common documents file types
__API_GITHUB: your personal Github API key
__RESOLVERS: path to public resolvers file 
__NOTES: path to the directory containing your markdown notes for qq-notes
__MNU_UA: path to the a file containing user-agent strings
__MNU_WORDLISTS: path to the a file containing a list of favorite wordlists

Commands
--------
qq-vars-global: list all current global variable values
qq-vars-global-set-*: used to set and save each individual variable

END
}

qq-vars-global() {
  echo "$(__cyan __IMPACKET: ) ${__IMPACKET}"
  echo "$(__cyan __EXT_PHP: ) ${__EXT_PHP}"
  echo "$(__cyan __EXT_DOCS: ) ${__EXT_DOCS}"
  echo "$(__cyan __API_GITHUB: ) ${__API_GITHUB}"
  echo "$(__cyan __NOTES: ) ${__NOTES}"
  echo "$(__cyan __RESOLVERS: ) ${__RESOLVERS}"
  echo "$(__cyan __MNU_UA: ) ${__MNU_UA}"
  echo "$(__cyan __MNU_WORDLISTS: ) ${__MNU_WORDLISTS}"
}

########## __IMPACKET

export __IMPACKET=$(cat ${__GLOBALS}/IMPACKET || echo "/usr/share/doc/python3-impacket/examples/")

qq-vars-global-set-impacket() {
  __ask "Set the full path to the python3-impacket/examples directory."
  __IMPACKET=$(__askpath DIR /)
  echo "${__IMPACKET}" > ${__GLOBALS}/IMPACKET
}

__check-impacket() { [[ -z "${__PROJECT}" ]] && qq-vars-global-set-impacket }

########## __EXT_PHP

export __EXT_PHP=$(cat ${__GLOBALS}/EXT_PHP || echo "php,phtml,pht,xml,inc,log,sql,cgi")

qq-vars-global-set-ext-php() {
  __ask "Enter a csv list of PHP server file extensions, ex: php,php3,pht"
  read "__EXT_PHP?$(__cyan EXTENSIONS: )"
  echo "${__EXT_PHP}" > ${__GLOBALS}/EXT_PHP
}

__check-ext-php()  { [[ -z "${__EXT_PHP}" ]] && qq-vars-global-set-ext-php } 

########## __EXT_DOCS

export __EXT_DOCS=$(cat ${__GLOBALS}/EXT_DOC || echo "doc,docx,pdf,xls,xlsx,txt,rtf,odt,ppt,pptx,pps,xml")

qq-vars-global-set-ext-docs() {
  __ask "Enter a csv list of document file extensions, ex: doc,xls,ppt"
  read "__EXT_DOCS?$(__cyan EXTENSIONS: )"
  echo "${__EXT_DOCS}" > ${__GLOBALS}/EXT_DOCS
}

__check-ext-docs()  { [[ -z "${__EXT_DOCS}" ]] && qq-vars-global-set-ext-docs } 

########## __API_GITHUB

export __API_GITHUB="$(cat $__USER/API_GITHUB 2> /dev/null)"

qq-vars-global-set-api-github() {
  __ask "Enter your github API key below."
  read "__API_GITHUB?$(__cyan APIKEY: )"
  echo "${__API_GITHUB}" > ${__GLOBALS}/API_GITHUB
}

__check-api-github()  { [[ -z "${__API_GITHUB}" ]] && qq-vars-global-set-api-github } 

########## __RESOLVERS

export __RESOLVERS=$(cat ${__GLOBALS}/RESOLVERS || echo "${__PAYLOADS}/resolvers.txt")

qq-vars-global-set-resolvers() {
  __ask "Set the full path to the file containing a list of resolvers."
  __RESOLVERS=$(__askpath FILE $HOME)
  echo "${__RESOLVERS}" > ${__GLOBALS}/RESOLVERS
}

__check-resolvers() { [[ -z "${__RESOLVERS}" ]] && qq-vars-global-set-resolvers }


########## __NOTES

export __NOTES="$(cat ${__GLOBALS}/NOTES 2> /dev/null)"

qq-vars-global-set-notes() {
  __ask "Set the full path to the directory containing markdown notes."
  __NOTES=$(__askpath DIR $HOME)
  echo "${__NOTES}" > ${__GLOBALS}/NOTES
}

__check-notes() { [[ -z "${__NOTES}" ]] && qq-vars-global-set-notes }

########## __MNU_UA

export __MNU_UA="$(cat ${__GLOBALS}/MNU_UA || echo "${__PAYLOADS}/user-agents.txt")"

qq-vars-global-set-mnu-ua() {
  __ask "Set the full path to the file containing a list of user agent strings"
  __MNU_UA=$(__askpath FILE $HOME)
  echo "${__MNU_UA}" > ${__GLOBALS}/MNU_UA
}

########## __MNU_WORDLISTS

export __MNU_WORDLISTS="$(cat ${__GLOBALS}/MNU_WORDLISTS || echo "${__PAYLOADS}/wordlists.txt")"

qq-vars-global-set-mnu-wordlists() {
  __ask "Set the full path to the file containing a list of favorite wordlists"
  __MNU_WORDLISTS=$(__askpath FILE $HOME)
  echo "${__MNU_WORDLISTS}" > ${__GLOBALS}/MNU_WORDLISTS
}