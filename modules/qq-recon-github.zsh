#!/usr/bin/env zsh

############################################################# 
# Recon Github
#############################################################

export __GH=https://github.com/search/

# grep -i "<query>" <dorks_file> | sed ':a;N;$!ba;s/\n/ OR /g'

qq-recon-github-git-search() {
    local p && read "p?Pattern: "
    { find .git/objects/pack/ -name "*.idx"|while read i;do git show-index < "$i"|awk '{print $2}';done;find .git/objects/ -type f|grep -v '/pack/'|awk -F'/' '{print $(NF-1)$NF}'; }|while read o;do git cat-file -p $o;done|grep -E '${p}'
}

qq-recon-github-by-user-curl() {
  local u && read "u:User: "
  print -z "curl -s \"https://api.github.com/users/${u}/repos?per_page=1000\" | jq '.[].git_url'"
}

qq-recon-github-top5() {
    local o && read "o?Org: "
    __info "${__GH}"
    local q=$(cat $GH_TOP5 | sed ':a;N;$!ba;s/\n/ OR /g')
    echo "${o} AND ${q}"
}


GH_TOP5 << END
security_credentials
connectionstring
ssh2_auth_password
send_keys
send,keys
END

GH_AWS << END
AKIA
amazon
s3cfg
AWS
S3
bucket
cloudfront
END

GH_API << END
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

GH_KEYS << END
-----BEGIN RSA PRIVATE KEY-----
-----BEGIN EC PRIVATE KEY-----
-----BEGIN PRIVATE KEY-----
-----BEGIN PGP PRIVATE KEY BLOCK-----
END

GH_B2B << END
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

GH_COMMS << END
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

GH_CLOUD << END
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

GH_AUTH << END
AUTH0
OKTA
END

GH_DOTFILES << END
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


GH_CMS << END
filename:wp-config
filename:wp-config.php
WORDPRESS_DB
MAGENTO_AUTH
MAGENTO_AUTH
MAGENTO_PASSWORD
CONTENTFUL_
END


GH_EXT << END
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