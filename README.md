# Quiver : A Meta-Tool for Kali Linux

Quiver is an organized namespace of shell functions that pre-fill commands in your terminal so that you can ditch your reliance on notes, copying, pasting, editing, copying and pasting again. Quiver helps you remember how to use every tool in your arsenal and doesn't hide them behind scripting that can be cumbersome to maintain or update. Instead you can use Quiver to build a composable, on-the-fly workflow for every situation. 

Quiver doesn't cover all tools, it's my own curated collection which I am still adding to and updating. There are so many tools for many different types of engagements and targets, so I jsut try to focus on tools that are maintained and current. Feel free to ask for the inclusion of tools you prefer in the issues list.

# Release 1.0 

After months of hard work during lockdown, I am happy to introduce the 1.0 release of Quiver! This version contains many improvements over previous versions such as per-namespace help and installers, auto-fill variables such as RHOST, RPORT, LHOST, LPORT, PROJECT, WORDLIST, URL and global configuration settings for customizing settings like a menu of your favorite wordlists. If you've been using Quiver before now, then many of the changes in 1.0 are breaking changes. Please familiarize yourself with the new commands using `qq-help`. If you previously were storing Quiver values in .zshrc, most of these can now be stored as global vars using `qq-vars-global`. 

* [RELEASES.md](RELEASES.md)

# Features

* Prefills the commands within a terminal
* Well-organized commands with tab auto-completion
* Installs as a ZSH / Oh-My-ZSH shell plugin
* Customizable settings, Global variables
* Recon phase commands for OSINT
* Enumeration of common services
* Web enumeration, brute-forcing and hacking
* Exploit compilation helpers
* Reverse shell handlers
* Content serving commands
* Built-in logbook for on-the-fly notes, saving commands
* Render markdown notes to the command line
* Kali Linux system management
* Update notification and install
* Installers for dependencies

# Installation

Quiver requires the following:

* ZSH (apt-get install zsh)
* oh-my-zsh (optional requirement but recommended: https://ohmyz.sh/)
* Kali Linux (https://kali.org)

Clone the repo to your OMZ custom plugins folder.

```bash

git clone https://github.com/stevemcilwain/quiver.git ~/.oh-my-zsh/custom/plugins/quiver

```
Edit ~/.zshrc to load the plugin.

```

plugins=(git quiver)

```

Source .zshrc to load the plugin and you're done. On first load, Quiver will install a few core packages.

```

source ~/.zshrc

```

## Getting Started

Quiver organizes commands into namespaces starting with `qq-`, such as `qq-enum-web` or `qq-recon-domains`.
To see an overview of all namespaces simply use `qq-help`. Each namespace also has it's own help command, such as `qq-enum-web-help` that provides a listing of available commands. All commands support tab completion and search. 

## Installing Dependencies

Every namespace was a qq-<namespace>-install command that will install all of the tools relavent to that namespace. You can install just the tools you need, or use `qq-install-all` to run the installers of all namespaces.

## Workflow

Quiver is meant to provide a composable, on-the-fly workflow. It replaces the common painful raw workflow of reading your notes, finding a command, copy, paste, replace the values with target values, copy, paste, run. Some rely heavily on completely automated scripts or frameworks that run all the commands for a workflow and output well-formatted data. While these scripts are great for many use cases, they can often be brittle, hide the underlying tools and techniques and be cumbersom to modify. Instead, Quiver gives you a happy medium, you can run commands quickly and easy with well-organized output, composing your workflow as you go depending on the targets and context. 

## Example Workflow

Here is an example workflow for bug bounty hunting:

### Prep

```bash

# if you have markdown notes, configure the path 
qq-vars-global-set-notes

# set some session variables for the bounty target 
qq-vars-set-project 
qq-vars-set-domain 

# generate scope files from the bounty url
qq-project-rescope

# save vars for other terminal sessions, qq-vars-load
qq-vars-save

```

### Passive Recon

```bash

# search for target files
qq-recon-org-files

# search downloaded files for urls
qq-recon-org-files-urls

# mine github repos for secrets
qq-recon-github-gitrob

# check dns records
qq-enum-dns-dnsrecon

# look for ASNs and networks
qq-recon-networks-amass-asns
qq-recon-networks-bgpview-ipv4

# get subdomains
qq-recon-subs-subfinder

# resolve and parse subdomains
qq-recon-subs-resolve-massdns
qq-recon-subs-resolve-parse

```

### Active Web Enumeration

```bash

# Download out robots.txt
qq-enum-web-dirs-robots

# ID a WAF if present
qq-enum-web-waf

# Parse SSL certs
qq-enum-web-ssl-certs

# Spider the site
qq-enum-web-gospider

# Brute force URIs
qq-enum-web-dirs-ffuf

# Read your notes
qq-notes

```
