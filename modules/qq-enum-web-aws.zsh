#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-aws
#############################################################

qq-enum-web-aws-s3-ls() {
  qq-vars-set-rhost
  print -z "aws s3 ls s3://${__RHOST} --recursive"
}

qq-enum-web-aws-s3-cp() {
  qq-vars-set-rhost
  local f=$(rlwrap -S "$fg[cyan]FILE(PUT): $reset_color" -e '' -c -o cat)
  print -z "aws s3 cp ${f} s3://${__RHOST}"
}

qq-enum-web-aws-s3-s3scanner() {
  local f=$(rlwrap -S "$fg[cyan]FILE(BUCKETS): $reset_color" -e '' -c -o cat)
  __info "Use -d to dump buckets to local path"
  print -z "python /opt/enum/S3Scanner/s3scanner.py ${f}"
} 
