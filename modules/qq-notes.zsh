#!/usr/bin/env zsh

############################################################# 
# qq-notes
#############################################################

qq-notes-help() {
  cat << END

qq-notes
-------
The notes namespace provides searching and reading of markdown notes.
Define the path to your notes by settings __NOTES=<path> in your .zshrc file.

Variables
---------
__NOTES: the path to your markdown notes

Commands
--------
qq-notes-install: installs dependencies
qq-notes: lists all notes in $__NOTES or searchs notes if $1 is supplied
qq-notes-search-file: 

END
}

qq-notes-install() {
  __info "Installing dependencies"
  sudo apt-get install fzf
  sudo apt-get install ripgrep
  wget https://github.com/sharkdp/bat/releases/download/v0.15.0/bat_0.15.0_amd64.deb && sudo dpkg -i bat_0.15.0_amd64.deb
}

# helpers

__notes-check() {
  if [[ -z $__NOTES ]]
  then
    __warn "Missing __NOTES environment variable." 
    __info "Add \"export __NOTES=<path_to_markdown_notes>\" to .zshrc"
    return
  fi
}

qq-notes() {
  __notes-check
  select note in $(ls -R --file-type ${__NOTES} | grep -ie ".md$" | grep -i "$1")
  do test -n ${note} && break
    exit
  done
  [[ ! -z ${note} ]] && glow ${__NOTES}/${note}
}

qq-notes-search-file() {
  local s && read "s?$(__ask SEARCH: )"
  qq-notes ${s}
}

qq-notes-search-word() {
  __notes-check
  select note in $(grep -rliw "$1" ${__NOTES}/*.md)
  do test -n ${note} && break
    exit
  done
  [[ ! -z ${note} ]] && glow ${note}
}

qq-notes-menu() {
  __notes-check
  cd ${__NOTES}
  rg --no-heading --no-line-number --with-filename --color=always --sort path -m1 "" *.md | fzf --tac --no-sort -d ':' --ansi --preview-window wrap --preview 'bat --style=plain --color=always ${1}'
  cd -
}

