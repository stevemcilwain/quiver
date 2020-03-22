#!/usr/bin/env zsh

############################################################# 
# qq-log
#############################################################

qq-log-set() {
    qq-vars-set-output

    [[ -z $__OUTPUT ]] && __err "__OUTPUT not set" && return 

    local log="${__OUTPUT}/logbook.md"
    
    if [[ -f "${log}" ]]; then
        __warn "${log} already exists, set as active log"
    else
        touch ${log}
        echo "# Logbook" >> ${log}
        echo " " >> ${log}
        __ok "${log} created."
    fi
}
alias qls="qq-log-set"

qq-log-cat() {
    log="${__OUTPUT}/logbook.md"
    __info "$log"
    glow ${log}
}
alias qlc="qq-log-cat"

qq-log-edit() {
    log="${__OUTPUT}/logbook.md"
    nano ${log}
}
alias qle="qq-log-edit"

qq-log() {
    log="${__OUTPUT}/logbook.md"
    if [[ -f "${log}" ]]; then

        local stamp=$(date +'%m-%d-%Y : %r')
        echo "## ${stamp}" >> ${log}
        echo "\`\`\`" >> ${log}
        echo "$@" >> ${log}
        echo "\`\`\`" >> ${log}
        echo " " >> ${log}

    else
        __err "Log file not set or not found"
    fi

}
alias ql="qq-log"