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

qq-log-set() {
    __LP=$1
    __ok "$1 set as active log"
}

qq-log-cat() {
    glow ${__LP}
}

qq-log-edit() {
    # I know... I know... you love your vim... just change it or make it a 
    # setting,I'm tired.
    nano ${__LP}
}

qq-log() {

    if [[ -f "${__LP}" ]]; then

        local stamp=$(date +'%m-%d-%Y : %r')
        echo "## ${stamp}" >> ${__LP}
        echo "\`\`\`" >> ${__LP}
        echo "$1" >> ${__LP}
        echo "\`\`\`" >> ${__LP}
        echo " " >> ${__LP}

    else
        __err "Log file not set or not found"
    fi

}
