#!/usr/bin/env zsh

############################################################# 
# Aliases
#############################################################

# system
alias agu="sudo apt-get update"
alias aguu="sudo apt-get update && sudo apt-get upgrade"
alias agi="sudo apt-get install"
alias agr="sudo apt autoremove"
alias cd..="cd ../"
alias cls="clear"
alias path="echo -e \${PATH//:/\\n}"
alias cp="cp -iv"
alias mv="mv -iv"
alias du='du -kh'
alias df='df -kTh'
alias lx='ls -lXB'
alias linestocsv="paste -s -d, -"
alias csvtolines="tr ',' '\n'"
alias mount="sudo mount | column -t"
alias zprint="cat ~/.zshrc"
alias znano="nano ~/.zshrc"
alias zsrc="source ~/.zshrc"
alias hp="httprobe -t 3000 -c 50 "
alias arec="asciinema rec"
alias aplay="asciinema play"

mcd () { mkdir -p "$1" && cd "$1"; }
sfu() { cat $1 | sort -u -o $1 }
sfip() { cat $1 | sort -u | sort -V -o $1 }
myip() { curl icanhazip.com }
netwatch() { print -z "_ watch -n 0.3 'netstat -pantlu | grep \"ESTABLISHED\|LISTEN\"' "}
netss() { print -z "_ ss -plunt" }
netls() { print -z "_ lsof -P -i -n "}
mem10() { print -z "_ ps aux | sort -rk 4,4 | head -n 10 | awk '{print \$4,\$11}' "}
ap() { echo "export PATH=\$PATH:$1" | tee -a ~/.zshrc }

