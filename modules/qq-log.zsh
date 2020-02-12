#!/usr/bin/env zsh

############################################################# 
# qq-recon
#############################################################

export __LP="~/logbook.md"

qq-log-new() {
    local n && read "n?Name: "
    local p && read "p?Path: "
    
    if [[ -f "${p}" ]]; then
    
        __LP=${p}
        __warn "${p} already exists, set as active log"

    else

        __LP=${p}
        touch ${__LP}
        echo "# Logbook - ${n}" >> ${__LP}
        echo " " >> ${__LP}
        __ok "${__LP} created."
    fi


}

qq-log-set() {

    local p && read "p?Logfile: "

    if [[ -f "${p}" ]]; then

        __LP=${p}
        __ok "${p} set as active log"

    else
        __err "${p} not found"
    fi
}

qq-log-cat() {

    if [[ -f "${__LP}" ]]; then

        glow ${__LP}

    else
        __err "${p} not found"
    fi
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
        __err "${p} not found"
    fi

}
