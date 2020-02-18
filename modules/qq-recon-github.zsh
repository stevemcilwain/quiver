#!/usr/bin/env zsh

############################################################# 
# qq-recon-github
#############################################################

# grep -i "<query>" <dorks_file> | sed 's/\(.*\)/"\1"/g' | sed ':a;N;$!ba;s/\n/ or /g'

qq-recon-github-git-search() {
    local p && read "p?PATTERN: "
    { find .git/objects/pack/ -name "*.idx"|while read i;do git show-index < "$i"|awk '{print $2}';done;find .git/objects/ -type f|grep -v '/pack/'|awk -F'/' '{print $(NF-1)$NF}'; }|while read o;do git cat-file -p $o;done|grep -E '${p}'
}

qq-recon-github-by-user-curl() {
    local u && read "u?USER: "
    print -z "curl -s \"https://api.github.com/users/${u}/repos?per_page=1000\" | jq '.[].git_url'"
}

qq-recon-github-by-domain-gwen-001() {
    [[ -z "${GH_TOKEN}" ]] && echo "GH_TOKEN env variable not set" && return;
    local d && read "d?DOMAIN: "
    print -z "python3 /opt/recon/github-search/github-endpoints.py -t ${GH_TOKEN} -d ${d} -r -s"
}

