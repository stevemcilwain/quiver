# quiver

Quiver is an opinionated and curated collection of commands, notes and scripts I use for bug bounty hunting.

[![asciicast](https://asciinema.org/a/ZHrUyUmGzNNxftclFG7xjc3Xe.svg)](https://asciinema.org/a/ZHrUyUmGzNNxftclFG7xjc3Xe)

## Features

* ZSH / Oh-My-ZSH shell plugin
* Tab auto-completion
* Prefills the command line, doesn't hide commands from you
* Built-in logbook for on-the-fly notes, saving commands
* Renders markdown notes to the command line
* Runs custom scripts
* Modular, easy updates

## Requirements

* ZSH
* oh-my-zsh
* Kali Linux
* Dependent packages

## Installation

Clone the repo to your custom plugins folder.

```bash

git clone https://github.com/stevemcilwain/quiver.git ~/.oh-my-zsh/custom/plugins/quiver
cd ~/.oh-my-zsh/custom/plugins/quiver
git config core.fileMode false
cd -

```
Edit ~/.zshrc to load the plugin.

```

plugins=(git quiver)

```

Source .zshrc

```

source ~/.zshrc

```

## Setting up Kali Linux Dependencies

To install dependent packages, data and tools run the included install script.  This will only install the tools needed in the plugin (previous install script was too large).

```

qq-install

```

## Usage

Use tab completion to view commands.

```

qq-<tab>

```

### Namespaces

Quiver is organized into namespaces for easy tab navigation:

* qq-loq: create, log and view a running logbook for your notes and commands
* qq-recon
* qq-recon-asns
* qq-recon-cidr
* qq-recon-domains
* qq-recon-github
* qq-recon-subs
* qq-enum
* qq-enum-network
* qq-enum-host
* qq-enum-dns 
* qq-enum-ftp
* qq-enum-web
* qq-enum-web-aws
* qq-enum-web-dirs
* qq-enum-web-vuln
* qq-srv

Quiver also sets up helpful shell aliases and functions (qq-aliases).

### Notes

Markdown notes are stored in the /notes subfolder and rendered by module commands.

### Scripts

Sometimes scripts are invoked from modules and those are stored in the /scripts subfolder.

