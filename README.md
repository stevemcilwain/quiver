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

## Usage

Use tab completion to view commands.

```

qq-<tab>

```

### Namespaces

Quiver is organized into namespaces for easy tab navigation:

* qq-util: utility functions and aliases, including self-update
* qq-log: create, log and view a running logbook for your notes and commands
* qq-recon:  recon commands
* qq-enum:  enumeration phase commands
* qq-enum-network:  network scanning and enumeration commands
* qq-enum-host:  host scanning and enumeration commands
* qq-enum-web:  web enumeration commands
* qq-enum-dns: dns enumeration commands
* qq-srv: service hosting commands
  
## Setting up Kali Linux

To install dependent packages, data and tools run the included install script on a fresh Kali Linux installation.

```

qq-kali-install

```
 
