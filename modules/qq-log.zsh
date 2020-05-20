#!/usr/bin/env zsh

############################################################# 
# qq-log
#############################################################

qq-log-help() {
  cat << END

qq-log
-------------
The log namespace provides commands that create a logbook in
a directory you specify. Then use qq-log to append entries
to the logbook. Display the log with qq-log-cat. Edit the log
with qq-log-edit.

Commands
--------
qq-log-install: installs dependencies
qq-log: alias ql, appends $@ to an entry in the logbook
qq-log-cat: alias qlc, cats the logbook
qq-log-edit: alias qle, edits the logbook using $EDITOR
qq-log-set: creates or uses existing logbook.md in the path specified

END
}

qq-log-install() {

  qq-install-golang
  go get -u github.com/charmbracelet/glow

}

qq-log-set() {
    qq-vars-set-logbook
}
alias qls="qq-log-set"

qq-log-cat() {
    __check-logbook
    __info "${__LOGBOOK}"
    glow ${__LOGBOOK}
}
alias qlc="qq-log-cat"

qq-log-edit() {
    __check-logbook
    $EDITOR ${__LOGBOOK}
}
alias qle="qq-log-edit"

qq-log() {
    __check-logbook

    local stamp=$(date +'%m-%d-%Y : %r')
    echo "## ${stamp}" >> ${__LOGBOOK}
    echo "\`\`\`" >> ${__LOGBOOK}
    echo "$@" >> ${__LOGBOOK}
    echo "\`\`\`" >> ${__LOGBOOK}
    echo " " >> ${__LOGBOOK}

}
alias ql="qq-log"