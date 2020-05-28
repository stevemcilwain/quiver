#!/usr/bin/env zsh

############################################################# 
# qq-enum-web-aws
#############################################################

qq-enum-web-aws-help() {
  cat << "DOC"

qq-enum-web-aws
---------------
The qq-enum-web-aws namespace contains commands for scanning 
and enumerating AWS hosted services.

Commands
--------
qq-enum-web-aws-install:     installs dependencies
qq-enum-web-aws-s3-ls:       use the awscli to list files in an S3 bucket
qq-enum-web-aws-s3-write:    use the awscli to copy a local file to an S3 bucket
qq-enum-web-aws-s3-scanner:  scan a list of buckets

DOC
}

qq-enum-web-aws-install() {
    __pkgs awscli
    qq-install-s3scanner
}

qq-enum-web-aws-s3-ls() {
  qq-vars-set-rhost
  print -z "aws s3 ls s3://${__RHOST} --recursive"
}

qq-enum-web-aws-s3-write() {
  qq-vars-set-rhost
  __ask "Select a file to copy to the S3 bucket"
  local f && __askpath f FILE $(pwd)
  print -z "aws s3 cp \"${f}\" s3://${__RHOST}"
}

qq-enum-web-aws-s3-scanner() {
  __ask "Select a file that contains a list of S3 buckets"
  local f && __askpath f FILE $(pwd)
  __info "Use -d to dump buckets to local path"
  print -z "python3 ${__TOOLS}/S3Scanner/s3scanner.py ${f}"
} 
