#!/usr/bin/env python3
# coding=utf-8

# *******************************************************************
# *** Wildcards ***
# * Description:
#   A script that does recon on public bug bounty wildcard domains.
# * Version:
#   v0.1
# * Homepage:
#   https://github.com/stevemcilwain/wildcards
# * Author:
#   Steve Mcilwain
# *******************************************************************

# Modules

import sys
import requests
import os

# Configuration
WILDCARDS_URL = "https://raw.githubusercontent.com/arkadiyt/bounty-targets-data/master/data/wildcards.txt"
WILDCARDS_FILE = "wildcards.txt"

# Colors

def print_red(skk): print("\033[91m{}\033[00m" .format(skk)) 
def print_cyan(skk): print("\033[96m{}\033[00m" .format(skk)) 
def print_yellow(skk): print("\033[93m{}\033[00m" .format(skk)) 

# Workflow

def download_file_from_url(url, file):
    result = False

    r = requests.get(url, allow_redirects=True)

    if r.status_code == 200:
        with open(file, "wb") as f:
            f.write(r.content)
            result = True
    else:
        result = False

    return (result, r.status_code)

def read_domains_from_file(file):
    result = False
    domains = set()

    with open(file, "r") as f:
        for line in f:
            if line.startswith("*."):
                domain=line[2:].rstrip("\n")
                domains.add(domain)
        result = True
    
    return (result, domains)

def main():

    print(" ")
    print_cyan("Wildcards")
    print(" ")
    print_cyan("[INFO] Roundin 'em up!")

    results = download_file_from_url(WILDCARDS_URL, WILDCARDS_FILE)
    if not results[0]: sys.exit("[ERR] Failed to download file: {}".format(results[1]))

    print("[INFO] Wrangled into: {}".format(WILDCARDS_FILE))

    results = read_domains_from_file(WILDCARDS_FILE)
    if not results[0]: sys.exit("[ERR] Failed to download file")

    #for domain in domains:
        #print("Domain: " + domain)

if (__name__ == "__main__"):
    try:
        main()
    except KeyboardInterrupt:
            print('\nKeyboardInterrupt Detected.')
            print('\nExiting...')
            exit(0)