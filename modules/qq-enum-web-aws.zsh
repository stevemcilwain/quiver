#!/usr/bin/env zsh

############################################################# 
# Web - AWS
#############################################################

qq-enum-web-aws-s3-ls() {
  local r && read "r?RHOST: "
  print -z "aws s3 ls s3://${r} --recursive"
}

qq-enum-web-aws-s3-cp() {
  local r && read "r?RHOST: "
  local f && read "f?File: "
  print -z "aws s3 cp ${f} s3://${r}"
}

qq-enum-web-aws-s3-s3scanner() {
  local p && read "p?Path to buckets file: "
  info "Use -d to dump buckets to local path"
  print -z "python /opt/enum/S3Scanner/s3scanner.py ${p}"
} 
