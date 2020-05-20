#!/usr/bin/env zsh

############################################################# 
# qq-project
#############################################################

qq-project-help() {
  cat << END

qq-project
-------------
The project namespace provides commands to setup custom project
directory structures and variables. This is an expirimental 
namespace and not commonly used.

Variables
---------
__PROJECT_ZD_CONSULTANT: a global variable for consultant name used in ZD projects
__PROJECT_ZD_ROOT: a global variable for the project root folder used in ZD projects

Commands
--------
qq-project-zd-start: scaffolds directory structure and logbook for "zd" projects
qq-project-zd-end: zips and removes directories and data for "zd" projects
qq-project-zd-root-set: sets the __PROJECT_ZD_ROOT variable
qq-project-zd-consultant-set: sets the __PROJECT_ZD_CONSULTANT variable

END
}

export __PROJECT_ZD=""
export __PROJECT_ZD_CONSULTANT="$(cat ${__USER}/__PROJECT_ZD_CONSULTANT 2> /dev/null)"
export __PROJECT_ZD_ROOT="$(cat ${__USER}/__PROJECT_ZD_ROOT 2> /dev/null)"

__check-project-zd() {
  if [[ -z $__PROJECT_ZD_CONSULTANT ]]
  then
    qq-project-zd-root-set
  fi
  if [[ -z $__PROJECT_ZD_ROOT ]]
  then
    qq-project-zd-consultant-set
  fi
}

qq-project-zd-root-set() {
  __warn "Enter the full path to the root folder of your projects."
  __PROJECT_ZD_ROOT=$(rlwrap -S "$(__cyan DIR: )" -e '' -P "$HOME" -c -o cat)
  echo "${__PROJECT_ZD_ROOT}" > ${__USER}/PROJECT_ZD_ROOT
  __ok "Saved in ${__USER}/PROJECT_ZD_ROOT"
}

qq-project-zd-consultant-set() {
  __warn "Enter consultant name below."
  __PROJECT_ZD_CONSULTANT=$(rlwrap -S "$(__cyan NAME: )" -e '' -P "$HOME" -c -o cat)
  echo "${__PROJECT_ZD_CONSULTANT}" > ${__USER}/PROJECT_ZD_CONSULTANT
  __ok "Saved in ${__USER}/PROJECT_ZD_CONSULTANT"
}

qq-project-zd-start() {

    __check-project-zd

    local pid && read "pid?$(__cyan PROJECT ID: )"
    local pname && read "pname?$(__cyan PROJECT Name: )"
    local fname="${pid}-${pname}-${__CONSULTANT_NAME// /}"
    local fullpath=${__PROJECT_ROOT}/${fname}

    #scaffold
    mkdir -p ${fullpath}/{burp/{log,intruder,http-requests},client-supplied-info/emails,files/{downloads,uploads},notes/screenshots,scans/{raw,pretty},ssl,tool-output}
    __PROJECT=${fullpath}/tool-output

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

    __check-project-zd

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