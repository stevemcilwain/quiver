#!/usr/bin/env bash

############################################################# 
# wildcards.sh
#
# This script is intended to run on a VPS as a cron job.
# Run it nightly and it will any newly discovered sub domains
# from the list of root domains that use wildcard scope.
#############################################################

# Set an environment variable in your .bashrc for your Slack webhook
# export __WILDCARDS_SLACK="https://hooks.slack.com/services/<webhook>"

# Setup cron to run at a certain hour every night, example below at 2 am
# crontab -e
# m h  dom mon dow   command
# 0 2 * * * /bin/bash /path/to/wildcards.sh

[[ -z $1 ]] && __err "Missing argument.\nUsage: bash $0 <file>" && exit

FILE=$1
DIR=$(pwd)

for WILDCARD in $(cat $FILE)
do
    amass enum -active -ip -d $DOMAIN
    DIFF=$(amass track -d $DOMAIN -last 2 | grep Found | awk '{print $2}')
    if [[ ! -z "$DIFF" ]]
    then
        curl -X POST --data-urlencode payload="{\"text\": \"$DIFF\"}" $__WILDCARDS_SLACK
    fi
done
