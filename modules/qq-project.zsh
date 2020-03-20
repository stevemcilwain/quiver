#!/usr/bin/env zsh

############################################################# 
# qq-project
#############################################################

export __PD=""

qq-project-zd-start() {

    if [[ -z $__PROJECT_ROOT ]]
    then
        __warn "Missing __PROJECT_ROOT environment variable." 
        __info "Add \"export __PROJECT_ROOT=<path_to_root-directory>\" to .zshrc"
        return
    fi

    if [[ -z $__CONSULTANT_NAME ]]
    then
        __warn "Missing __CONSULTANT_NAME environment variable." 
        __info "Add \"export __CONSULTANT_NAME=<name>\" to .zshrc"
        return
    fi

    # if [[ -z $__CONSULTANT_EMAIL ]]
    # then
    #     __warn "Missing __CONSULTANT_EMAIL environment variable." 
    #     __info "Add \"export __CONSULTANT_EMAIL=<name>\" to .zshrc"
    #     return
    # fi

    local pid && read "pid?$fg[cyan]Project ID:$reset_color "
    local pname && read "pname?$fg[cyan]Project Name:$reset_color "
    
    __PD="${pid}-${pname}-${__CONSULTANT_NAME// /}"

    mkdir -p ${__PROJECT_ROOT}/${__PD}/{burp/{log,intruder,http-requests},client-supplied-info/emails,files/{downloads,uploads},notes/screenshots,scans/{raw,pretty},ssl,tool-output}

    # wanted this to be an optional step, sometimes I'll create folders in advance due to calls with clients ahead of the test or prep work
    local setlog && read "setlog?$fg[cyan]Add a log file for this project (y/n)?:$reset_color "
    case "$setlog" in 
        y|Y ) 
            qq-log-set
            ;;
        n|N ) 
            echo "no"
            ;;
        * ) 
            echo ""
            ;;
    esac   

}

qq-project-zd-end() {

    if [[ -z $__PROJECT_ROOT ]]
    then
        __warn "Missing __PROJECT_ROOT environment variable." 
        __info "Add \"export __PROJECT_ROOT=<path_to_root-directory>\" to .zshrc"
        return
    fi

    __ask "Select a project folder: "
    local pd=$(__menu-helper $(find $__PROJECT_ROOT -mindepth 1 -maxdepth 1 -type d))
    __ok "Selected: ${pd}"


    # Task 1: delete all empty folders
    local df && read "df?$fg[cyan]Delete empty folders? (Y/n)?:$reset_color "
    if [[ "$df" =~ ^[Yy]$ ]]
    then
        find ${pd} -type d -empty -delete 
        __ok "Empty folders deleted."
    fi

    # Task 2: create tree
    cd ${pd}
    tree -C -F -H ./ > ${pd}/tree.html 
    [[ -f "${pd}/tree.html" ]] && __ok "Created ${pd}/tree.html." || __err "Failed creating ${pd}/tree.html"
    cd - > /dev/null 2>&1
    
    # Task 3: zip up engagement folder
    local zf=$(basename ${pd})
    7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=1024m -ms=on ${__PROJECT_ROOT}/${zf}.7z ${pd} > /dev/null 2>&1
    [[ -f ${__PROJECT_ROOT}/${zf}.7z ]] && __ok "Zipped files into ${__PROJECT_ROOT}/${zf}.7z." || __err "Failed to zip ${pd}"

    # Task 4: Delete engagement folder
    local rmp && read "rmp?$fg[cyan]Delete project folder? (Y/n)?:$reset_color "
    if [[ "${rmp}" =~ ^[Yy]$ ]] && print -z "rm -rf ${pd}"

    __ok "Project ended."
}