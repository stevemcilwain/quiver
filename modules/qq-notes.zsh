#!/usr/bin/env zsh

############################################################# 
# qq-notes
#############################################################

qq-notes-help() {
  cat << "DOC"

qq-notes
-------
The notes namespace provides searching and reading of markdown notes that are
stored in a directory specified by the __NOTES environment variable (qq-vars-global).

Commands
--------
qq-notes-install:     installs dependencies
qq-notes:             lists all notes in $__NOTES or searches notes by filename if $1 is supplied
qq-notes-content:     list all notes in $__NOTES or searches notes by content if $1 is supplied
qq-notes-menu:        display an interactive menu for reading notes

DOC
}

qq-notes-install() {
  __pkgs fzf ripgrep
  qq-install-golang
  go get -u github.com/charmbracelet/glow
  wget https://github.com/sharkdp/bat/releases/download/v0.15.0/bat_0.15.0_amd64.deb && sudo dpkg -i bat_0.15.0_amd64.deb
  
}

qq-notes() {
  __notes-check
  __info "Use \$1 to search file names"
  select note in $(ls -R --file-type ${__NOTES} | grep -ie ".md$" | grep -i "$1")
  do test -n ${note} && break
    exit
  done
  [[ ! -z ${note} ]] && glow ${__NOTES}/${note}
}

qq-notes-content() {
  __notes-check
  __info "Use \$1 to search content"
  select note in $(grep -rliw "$1" ${__NOTES}/*.md)
  do test -n ${note} && break
    exit
  done
  [[ ! -z ${note} ]] && glow ${note}
}

qq-notes-menu() {
  __notes-check
  pushd ${__NOTES} &> /dev/null
  rg --no-heading --no-line-number --with-filename --color=always --sort path -m1 "" *.md | fzf --tac --no-sort -d ':' --ansi --preview-window wrap --preview 'bat --style=plain --color=always ${1}'
  popd &> /dev/null
}
