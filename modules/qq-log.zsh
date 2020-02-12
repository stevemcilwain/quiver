#!/usr/bin/env zsh

############################################################# 
# qq-recon
#############################################################

export __LP="~/logbook.md"

qq-log-new() {
    local n && read "n?Name: "
    local p && read "p?Path: "
    
    if [[ -f "${p}" ]]; then
        echo "${p} already exists"
        return
    fi

    __LP=${p}
    touch ${__LP}
    echo "# Logbook - ${n}" >> ${__LP}
    echo " " >> ${__LP}
}

qq-log() {
    local stamp=$(date +'%m-%d-%Y : %r')
    echo "## ${stamp}" >> ${__LP}
    echo "\`\`\`" >> ${__LP}
    echo "$1" >> ${__LP}
    echo "\`\`\`" >> ${__LP}
    echo " " >> ${__LP}
}
