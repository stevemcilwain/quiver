#!/usr/bin/env zsh

############################################################# 
# quiver
# Author: Steve Mcilwain
# Contributors: 
#############################################################
__VER=0.3.0

echo " "
echo "$fg[cyan][*] quiver ${__VER} loading...$reset_color"

autoload colors; colors

#Ssource all qq scripts

for f in ${0:A:h}/modules/qq-* ; do
  echo "[+] quiver sourcing $f ... "
  source $f;
done

# Ensure all scripts are executable

for s in ${0:A:h}/scripts/*.sh ; do
  chmod +x $s;
done

############################################################# 
# Output Helpers
#############################################################

__info() echo "$fg[blue][*] $1$reset_color"
__ok()   echo "$fg[green][+] $1$reset_color"
__ok-clip() __ok "The command was copied to the clipboard."
__warn() echo "$fg[yellow][?] $1$reset_color"
__err()  echo "$fg[red][!] $1$reset_color"
__clip() xclip -selection c

############################################################# 
# Constants
#############################################################

export __NOTES="${0:A:h}/notes"
export __SCRIPTS="${0:A:h}/scripts"

export __WORDS_ALL="/opt/words/all/all.txt"
export __WORDS_NULL="/opt/words/nullenc/null.txt"
export __WORDS_COMMON="/usr/share/seclists/Discovery/Web-Content/common.txt"
export __WORDS_RAFT_DIRS="/usr/share/seclists/Discovery/Web-Content/raft-large-words.txt"
export __WORDS_QUICK="/usr/share/seclists/Discovery/Web-Contant/quickhits.txt"
export __WORDS_MEDIUM="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
export __WORDS_RAFT_FILES="/usr/share/seclists/Discovery/Web-Content/raft-large-files.txt"
export __WORDS_SWAGGER="/usr/share/seclists/Discovery/Web-Content/swagger.txt"

export __PASS_ROCKYOU="/usr/share/wordlists/rockyou.txt"

export __UA_GOOGLEBOT="Googlebot/2.1 (+http://www.google.com/bot.html)"
export __UA_CHROME="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
export __UA_IOS="Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
export __UA=__UA_CHROME

export __FDNS=""
export __RDNS=""

export __IMPACKET="/usr/share/doc/python3-impacket/examples"

############################################################# 
# Runtime Helpers
#############################################################

export __IFACES=$(ip addr list | awk -F': ' '/^[0-9]/ {print $2}')

############################################################# 
# Update
#############################################################

qq-update() {
  cd ~/.oh-my-zsh/custom/plugins/quiver
  git pull
  cd -
  source ~/.zshrc
}

qq-kali-install() {
  print -z "${__SCRIPTS}/install-kali.sh"
}


echo "$fg[cyan][*] quiver loaded.$reset_color"
echo " "
























#sudo masscan -p4443,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,443,744$}

#massdns -r $Tools/massdns/lists/resolvers.txt -t A -o S allsubdomains.txt -w livesubdomains.messy

# sed 's/A.*//' livesubdomains.messy | sed 's/CN.*//' | sed 's/\..$//' > domains.resolved

#cat domains.resolved | httprobe -c 50 | tee http.servers

#cp http.servers $Tools
#$Tools/EyeWitness/eyewitness.py --web -f http.servers

#python $Tools/S3Scanner/s3scanner.py -l domains.resolved -o buckets.txt

#-d flag will dump all open buckets locally

#If you find open buckets you can run the useful bash look to enumerate content

#for i in $(cat buckets.txt); do aws s3 ls s3://$i; done;

#This will require basic auth key/secret which you can get for free from AWS



#!/bin/bash
#mkdir headers
#mkdir responsebody
#CURRENT_PATH=$(pwd)

#for x in $(cat $1)
#do
#        NAME=$(echo $x | awk -F/ '{print $3}')
#        curl -X GET -H "X-Forwarded-For: evil.com" $x -I > "$CURRENT_PATH/headers/$NAME"
#        curl -s -X GET -H "X-Forwarded-For: evil.com" -L $x > "$CURRENT_PATH/responsebody/$NAME"
#done




### S3

# https://github.com/jordanpotti/AWSBucketDump

# Configure AWS CLI in your Windows/Linux/Mac machine.
# Execute the below commands from the CLI
# Uploading a file — aws s3 cp test.html s3://<xyz>-uploads/
# Deleting a file — aws s3 rm s3://<xyz>-uploads/test.html
# Listing the files — aws s3 ls s3://<xyz>-uploads/

# Lazy S3
# 2) bucket_finder
# 3) AWS Cred Scanner
# 4) sandcastle
# 5) Mass3
# 6) Dumpster Diver
# 7) S3 Bucket Finder
# 8) S3Scanner