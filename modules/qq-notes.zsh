#!/usr/bin/env zsh

############################################################# 
# qq-notes
#############################################################

qq-notes-help() {

}

qq-notes-install() {
  __info "Installing dependencies"
  sudo apt-get install fzf
  wget https://github.com/sharkdp/bat/releases/download/v0.15.0/bat_0.15.0_amd64.deb && sudo dpkg -i bat_0.15.0_amd64.deb
  sudo apt-get install ripgrep
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

__notes() {
  __notes-check
  
  rg --no-heading --no-line-number --with-filename --color=always --sort path -m1 "" ${__NOTES}/*.md | fzf --tac --no-sort -d ':' --ansi --preview-window wrap --preview 'bat --style=plain --color=always ${1}'

  #select note in $(ls -R --file-type ${__NOTES} | grep -ie ".md$" | grep -i "$1")

  # do test -n ${note} && break
  #   exit
  # done

  #[[ ! -z ${note} ]] && glow ${__NOTES}/${note}
}

qq-notes() {
  __notes $1
}

qq-notes-search() {
  local s && read "s?__prompt SEARCH: "
  __notes ${s}
}

qq-notes-menu() {
  __notes-check
  rg --no-heading --no-line-number --with-filename --color=always --sort path -m1 "" ${__NOTES}/*.md | fzf --tac --no-sort -d ':' --ansi --preview-window wrap --preview 'bat --style=plain --color=always ${1}'
}

__prompt() {
  $fg[cyan]$1$reset_color
}