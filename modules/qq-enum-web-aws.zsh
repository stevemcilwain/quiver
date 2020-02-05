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

# 
# 
