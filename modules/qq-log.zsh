#!/usr/bin/env zsh

############################################################# 
# qq-log
#############################################################

export __LP="~/logbook.md"

qq-log-new() {
    local n && read "n?NAME: "
    local f && read "f?FILE: "
    
    if [[ -f "${f}" ]]; then
    
        __LP=${f}
        __warn "${f} already exists, set as active log"

    else

        __LP=${f}
        touch ${__LP}
        echo "# Logbook - ${n}" >> ${__LP}
        echo " " >> ${__LP}
        __ok "${__LP} created."
    fi

}
alias qln="qq-log-new"

qq-log-set() {
    __LP=$@
    __ok "$1 set as active log"
}

qq-log-cat() {
    glow ${__LP}
}
alias qlc="qq-log-cat"

qq-log-edit() {
    $EDITOR ${__LP}
}

qq-log() {

    if [[ -f "${__LP}" ]]; then

        local stamp=$(date +'%m-%d-%Y : %r')
        echo "## ${stamp}" >> ${__LP}
        echo "\`\`\`" >> ${__LP}
        echo "$@" >> ${__LP}
        echo "\`\`\`" >> ${__LP}
        echo " " >> ${__LP}

    else
        __err "Log file not set or not found"
    fi

}
alias ql="qq-log"