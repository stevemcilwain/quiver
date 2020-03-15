#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-aws
#############################################################

qq-enum-web-aws-s3-ls() {
  __GET-RHOST
  print -z "aws s3 ls s3://${__RHOST} --recursive"
}

qq-enum-web-aws-s3-cp() {
  __GET-RHOST
  local f=$(rlwrap -S 'FILE(PUT): ' -e '' -c -o cat)
  print -z "aws s3 cp ${f} s3://${__RHOST}"
}

qq-enum-web-aws-s3-s3scanner() {
  local f=$(rlwrap -S 'FILE(BUCKETS): ' -e '' -c -o cat)
  __info "Use -d to dump buckets to local path"
  print -z "python /opt/enum/S3Scanner/s3scanner.py ${f}"
} 
