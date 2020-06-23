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
# 0 2 * * * /bin/bash /path/to/wildcards.sh <domain> <webhook url>

DOMAIN=$1
SLACK=$2

if [[ -z "$DOMAIN" ]]
then
        echo "[x] Missing domain"
        exit 1
fi

echo $(date) >> log.txt
echo "$DOMAIN" >> log.txt
echo "$SLACK" >> log.txt

curl -X POST --data-urlencode payload="{\"text\": \"Wildcards starting for $DOMAIN \"}" $SLACK

amass enum -active -ip -d $DOMAIN
DIFF=$(amass track -d $DOMAIN -last 2 | grep Found | awk '{print $2}')

echo "Diff: $DIFF" >> log.txt

if [[ ! -z "$DIFF" ]]
then
        curl -X POST --data-urlencode payload="{\"text\": \"$DIFF\"}" $SLACK
fi

curl -X POST --data-urlencode payload="{\"text\": \"Wildcards completed for $DOMAIN \"}" $SLACK