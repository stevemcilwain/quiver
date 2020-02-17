#!/usr/bin/env zsh

############################################################# 
# qq-recon-github
#############################################################

# grep -i "<query>" <dorks_file> | sed ':a;N;$!ba;s/\n/ OR /g'

qq-recon-github-git-search() {
    local p && read "p?PATTERN: "
    { find .git/objects/pack/ -name "*.idx"|while read i;do git show-index < "$i"|awk '{print $2}';done;find .git/objects/ -type f|grep -v '/pack/'|awk -F'/' '{print $(NF-1)$NF}'; }|while read o;do git cat-file -p $o;done|grep -E '${p}'
}

qq-recon-github-by-user-curl() {
  local u && read "u:USER: "
  print -z "curl -s \"https://api.github.com/users/${u}/repos?per_page=1000\" | jq '.[].git_url'"
}

qq-recon-github-dorks-top5() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_TOP5}"
}

__GH_TOP5=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
security_credentials
connectionstring
ssh2_auth_password
send_keys
send,keys
END
)

qq-recon-github-dorks-aws() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_AWS}"
}

__GH_AWS=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
AKIA
amazon
s3cfg
AWS
S3
bucket
cloudfront
END
)

qq-recon-github-dorks-api() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_API}"
}

__GH_API=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
access_token
API Secret
access_secret
api_key
client_secret
consumer_secret
customer_secret
user_secret
secret_key
END
)

qq-recon-github-dorks-keys() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_KEYS}"
}

__GH_KEYS=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
-----BEGIN RSA PRIVATE KEY-----
-----BEGIN EC PRIVATE KEY-----
-----BEGIN PRIVATE KEY-----
-----BEGIN PGP PRIVATE KEY BLOCK-----
END
)

qq-recon-github-dorks-b2b() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_B2B}"
}

__GH_B2B=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
EAA
EAACEd
EAACEdEose0cBA 
AIza
.apps.googleusercontent.com
sq0atp
sq0csp
key-
sk_live_ 
rk_live_
END
)

qq-recon-github-dorks-comms() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_COMMS}"
}

__GH_COMMS=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
removed prod
deleted prod
removed data
deleted data
sanitized 
hardcoded
production
staging
sensitive
insecure
unsecure
vulnerability
encrypted
END
)

qq-recon-github-dorks-cloud() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_CLOUD}"
}

__GH_CLOUD=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
AMAZON
AWS
APIARY
CLOUDFLARE
CLOUDANT
CONTENTFUL
DIGITALOCEAN
DOCKER
FIREBASE
GCLOUD
HEROKU
LINODE
NETLIFY
NGROK
SALESFORCE
WATSON
OPENSTACK
END
)

qq-recon-github-dorks-dotfiles() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_DOTFILES}"
}

__GH_DOTFILES=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
filename:bash_history
filename:bash_profile
filename:bashrc
filename:zshrc
filename:zsh_history
filename:.sh_history
filename:robomongo.json
filename:id_rsa
filename:id_dsa
filename:.dockercfg auth
filename:filezilla.xml Pass
END
)

qq-recon-github-dorks-cms() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_CMS}"
}

__GH_CMS=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
filename:wp-config
filename:wp-config.php
WORDPRESS_DB
MAGENTO_AUTH
MAGENTO_AUTH
MAGENTO_PASSWORD
CONTENTFUL_
END
)

qq-recon-github-dorks-ext() {
    local o && read "o?ORG: "
    echo "${o} AND ${__GH_EXT}"
}

__GH_EXT=$(cat << END | sed ':a;N;$!ba;s/\n/ OR /g'
extension:bat
extension:json client_secret
extension:json mongolab.com
extension:pem private
extension:ppk private
extension:sh
extension:sql mysql dump password
extension:yaml mongolab.com
extension:zsh
END
)