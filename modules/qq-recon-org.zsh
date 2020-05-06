#!/usr/bin/env zsh

############################################################# 
# qq-recon-org
#############################################################

qq-recon-org-help() {
  cat << END

qq-recon-org
------------
The recon namespace provides commands for the recon of an organization.

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
  sudo apt-get install theHarvester
}

qq-recon-org-files-metagoofil() {
  qq-vars-set-output
  qq-vars-set-domain
  mkdir -p ${__OUTPUT}/recon/files
  local ft && read "ft?$(__cyan EXTENSIONS: )"
  print -z "metagoofil -u \"${__UA}\" -d ${__DOMAIN} -t ${ft} -o ${__OUTPUT}/recon/files"
}

qq-recon-org-wordlist-by-url-cewl() {
  qq-vars-set-output
  qq-vars-set-url
  mkdir -p ${__OUTPUT}/recon
  print -z "cewl -a -d 3 -m 5 -u \"${__UA}\" -w ${__OUTPUT}/recon/custom_list.txt ${__URL}"
}

qq-recon-org-theharvester() {
  qq-vars-set-output
  qq-vars-set-domain
  mkdir -p ${__OUTPUT}/recon
  print -z "theHarvester -d ${__DOMAIN} -l 50 -b all -f ${__OUTPUT}/recon/harvester.txt"
}
