# quiver

Quiver is an opinionated and curated collection of commands, notes and scripts I use for bug bounty hunting.

[![asciicast](https://asciinema.org/a/ZHrUyUmGzNNxftclFG7xjc3Xe.svg)](https://asciinema.org/a/ZHrUyUmGzNNxftclFG7xjc3Xe)

## Features

* ZSH / Oh-My-ZSH shell plugin
* Tab auto-completion
* Prefills the command line, doesn't hide commands from you
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

```
Edit ~/.zshrc to load the plugin.

```

plugins=(git extract quiver)

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
* qq-recon:  recon commands
* qq-enum-:  enumeration phase commands
* qq-enum-network:  network scanning and enumeration commands
* qq-enum-host:  host scanning and enumeration commands
* qq-enum-web:  web enumeration commands
* qq-enum-web-aws:  aws enumeration commands
* qq-enum-dns: dns enumeration commands
* qq-srv: service hosting commands
  
## Setting up Kali Linux

To install dependent packages and tools run the included install script.

```

qq-kali-install

```
 
