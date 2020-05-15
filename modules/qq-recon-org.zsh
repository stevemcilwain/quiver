#!/usr/bin/env zsh

############################################################# 
# qq-recon-org
#############################################################

qq-recon-org-help() {
  cat << END

qq-recon-org
------------
The recon namespace provides commands for the recon of an organization.
Data from commands will be stored in $__PROJECT/recon.

Commands
--------
qq-recon-org-install: installs dependencies
qq-recon-org-files-metagoofil: uses metagoofil to search and download files for a domain
qq-recon-org-wordlist-cewl: uses cewl to create a custom wordlist from a url
qq-recon-org-theharvester: uses theHarvester to mine data about a target domain

END
}

qq-recon-org-install() {
  sudo apt-get install metagoofil
  sudo apt-get install cewl
  sudo apt-get install theharvester
}

qq-recon-org-files-metagoofil() {
  __check-project
  qq-vars-set-domain
  mkdir -p ${__PROJECT}/recon/files
  local ft && read "ft?$(__cyan EXTENSIONS: )"
  print -z "metagoofil -u \"${__UA}\" -d ${__DOMAIN} -t ${ft} -o ${__PROJECT}/recon/files"
}

qq-recon-org-files-urls() {
  __check-project
  qq-vars-set-domain
  print -z "strings * | gf urls | grep $__DOMAIN >> ${__PROJECT}/recon/urls.txt"
}

qq-recon-org-wordlist-by-url-cewl() {
  __check-project
  qq-vars-set-url
  mkdir -p ${__PROJECT}/recon
  print -z "cewl -a -d 3 -m 5 -u \"${__UA}\" -w ${__PROJECT}/recon/cewl.txt ${__URL}"
}

qq-recon-org-theharvester() {
  __check-project
  qq-vars-set-domain
  mkdir -p ${__PROJECT}/recon
  print -z "theHarvester -d ${__DOMAIN} -l 50 -b all -f ${__PROJECT}/recon/harvested.txt"
}
