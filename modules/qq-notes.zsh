#!/usr/bin/env zsh

############################################################# 
# qq-notes
#############################################################

__notes() {
    
  if [[ -z $__NOTES ]]
  then
    __warn "Missing __NOTES environment variable." 
    __info "Add \"export __NOTES=<path_to_markdown_notes>\" to .zshrc"
    return
  fi

  select note in $(ls -R --file-type ${__NOTES} | grep -ie ".md$" | grep -i "$1")

  do test -n ${note} && break
    exit
  done

  [[ ! -z ${note} ]] && glow ${__NOTES}/${note}
}

qq-notes() {
  __notes $1
}

qq-notes-search() {
  local s && read "s?SEARCH: "
  __notes ${s}
}
