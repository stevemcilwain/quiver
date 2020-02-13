#!/usr/bin/env zsh

############################################################# 
# Aliases
#############################################################

# system
alias agu="apt-get update"
alias aguu="apt-get update && apt-get upgrade"
alias agi="apt-get install"
alias agr="apt autoremove"
alias cd..="cd ../"
alias cls="clear"
alias path="echo -e \${PATH//:/\\n}"
alias cp="cp -iv"
alias mv="mv -iv"
alias linestocsv="paste -s -d, -"
alias csvtolines="tr ',' '\n'"
alias mount="mount | column -t"
alias zcat="cat ~/.zshrc | less"
alias znano="nano ~/.zshrc"
alias zsrc="source ~/.zshrc"

mcd () { mkdir -p "$1" && cd "$1"; }
sfu() { cat $1 | sort -u -o $1 }
sfip() { cat $1 | sort -u | sort -V -o $1 }
myip() { curl icanhazip.com }
netwatch() { print -z "_ watch -n 0.3 'netstat -pantlu | grep \"ESTABLISHED\|LISTEN\"' "}
netss() { print -z "_ ss -plunt" }
netls() { print -z "_ lsof -P -i -n "}
mem10() { print -z "_ ps aux | sort -rk 4,4 | head -n 10 | awk '{print \$4,\$11}' "}
ap() { echo "export PATH=\$PATH:$1" | tee -a ~/.zshrc }

