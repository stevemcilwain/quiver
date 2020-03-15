#!/usr/bin/env zsh

############################################################# 
# qq-project
#############################################################

export __PROJECT_DIR="."
export __PROJECT_CLIENT="Org"

export __PROJECT_CONSULTANT_EMAIL="$USER@$HOST"
export __PROJECT_CONSULTANT_NAME="$USER"

export __PROJECT_CURRENT_IFACE=""
export __PROJECT_CURRENT_DOMAIN=""
export __PROJECT_CURRENT_NETWORK=""
export __PROJECT_CURRENT_HOST=""
export __PROJECT_CURRENT_URL=""

qq-project-set() {
    __PROJECT_DIR=$(rlwrap -S '__PROJECT_DIR: ' -e '' -c -o cat)

    if [[ -d "${__PROJECT_DIR}" ]]; then

        #load settings
        ${__PROJECT_CLIENT}=$(cat ${__PROJECT_DIR}/.settings/client)

        __info "Settings loaded."
        

    else

        mkdir -p ${__PROJECT_DIR}/.settings
        read "__PROJECT_CLIENT?__PROJECT_CLIENT: "
        echo "${__PROJECT_CLIENT}" > ${__PROJECT_DIR}/.settings/client
        
        __info "Settings saved."

        mkdir -p ${__PROJECT_DIR}/burp/{log,intruder,http-requests}
        mkdir -p ${__PROJECT_DIR}/client
        mkdir -p ${__PROJECT_DIR}/domains
        mkdir -p ${__PROJECT_DIR}/networks
        mkdir -p ${__PROJECT_DIR}/hosts
        mkdir -p ${__PROJECT_DIR}/files/{downloads,uploads}
        mkdir -p ${__PROJECT_DIR}/notes/screenshots
        mkdir -p ${__PROJECT_DIR}/{output/scans/{raw,pretty},ssl}
    fi
   

}


