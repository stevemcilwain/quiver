#!/usr/bin/env zsh

############################################################# 
# qq-recon-github
#############################################################

qq-recon-github-help() {
  cat << END

qq-recon-github
------------
The recon-github namespace provides commands for the recon of github repos.
All output will be stored under $__PROJECT/source

Commands
--------
qq-recon-github-install: installs dependencies
qq-recon-github-user-repos: uses curl to get a list of repos for a github user
qq-recon-github-endpoints: gets a list of urls from all repos of a domain on github
qq-recon-github-gitrob: clones (in mem) repos and searches for github dorks

END
}

qq-recon-github-install() {

    __pkgs curl jq python3 
    qq-install-golang
    qq-install-github-search
    qq-install-git-secrets
    qq-install-gitrob

}

qq-recon-github-user-repos() {
    __check-project
    local u && read "u?$(__cyan USER: )"
    mkdir -p ${__PROJECT}/source
    print -z "curl -s \"https://api.github.com/users/${u}/repos?per_page=1000\" | jq '.[].git_url' >> ${__PROJECT}/source/${u}.txt "
}

qq-recon-github-endpoints() {
    __check-gh-token
    __check-project
    qq-vars-set-domain
    mkdir -p ${__PROJECT}/source
    print -z "github-endpoints.py -t ${GH_TOKEN} -d ${__DOMAIN} >> ${__PROJECT}/source/${__DOMAIN}.endpoints.txt "
}


qq-recon-github-gitrob() {
    __check-gh-token
    __check-project
    local u && read "u?$(__cyan USER: )"
    local d=${__PROJECT}/source/${u}
    mkdir -p $d
    cp $HOME/go/src/github.com/codeEmitter/gitrob/filesignatures.json $d
    __info "Gitrob UI: http://127.0.0.1:9393/"
    print -z "pushd $d ;gitrob -in-mem-clone -save \"$d/output.json\" -github-access-token $GH_TOKEN ${u} && popd"
}

__check-gh-token() { [[ -z "${GH_TOKEN}" ]] && echo "GH_TOKEN env variable not set" && return; }