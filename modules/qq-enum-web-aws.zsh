#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-aws
#############################################################

qq-enum-web-aws-s3-ls() {
  local r && read "r?RHOST: "
  print -z "aws s3 ls s3://${r} --recursive"
}

qq-enum-web-aws-s3-cp() {
  local r && read "r?RHOST: "
  local f=$(rlwrap -S 'FILE_PUT: ' -e '' -c -o cat)
  print -z "aws s3 cp ${f} s3://${r}"
}

qq-enum-web-aws-s3-s3scanner() {
  local f=$(rlwrap -S 'FILE_BUCKETS: ' -e '' -c -o cat)
  __info "Use -d to dump buckets to local path"
  print -z "python /opt/enum/S3Scanner/s3scanner.py ${f}"
} 
