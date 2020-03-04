#!/usr/bin/env zsh

############################################################# 
# qq-aliases
#############################################################

# packages
alias agu="sudo apt-get update"
alias aguu="sudo apt-get update && sudo apt-get upgrade"
alias agi="sudo apt-get install"
alias agr="sudo apt autoremove"
alias agfix="sudo apt-get install --fix-broken && sudo apt-get autoremove && sudo apt-get update"

#nav
alias cd..="cd ../"
alias cls="clear"
alias path="echo -e \${PATH//:/\\n}"
alias cp="cp -iv"
alias mv="mv -iv"
alias du='du -kh'
alias df='df -kTh'
alias lx='ls -lXB'

#sys
alias mount="sudo mount | column -t"
alias mem10="qq-aliases-sys-mem10"
alias disk10="qq-aliases-sys-disk10"

#network
alias hp="httprobe -t 3000 -c 50 "
alias pcap="sudo tcpdump -r"
alias myip="qq-aliases-net-curl-public-ip"
alias netwatch="qq-aliases-net-watch-netstat"
alias netss="qq-aliases-net-ss"
alias netls="qq-aliases-net-lsof"
alias grip="grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'"

#zsh
alias zprc="cat ~/.zshrc"
alias znrc="nano ~/.zshrc"
alias zsrc="source ~/.zshrc"

#media
alias arec="asciinema rec"
alias aplay="asciinema play"

# files and directory
alias linestocsv="paste -s -d, -"
alias csvtolines="tr ',' '\n'"
alias f3="sudo find /etc /var -mtime -3"  #files changed in last 3 days
alias pa="qq-aliases-path-add"
alias mcd="qq-aliases-make-dir-cd"
alias tgf="qq-aliases-tail-grep-follow"
alias rnf="qq-aliases-replace-in-file"
alias sfu="qq-aliases-sort-file-uniq"
alias sfip="qq-aliases-sort-file-uniq-ip"
alias dos2unix="qq-aliases-dos-to-unix"
alias unix2dos="qq-aliases-unix-to-dos"
alias fsync="qq-aliases-rsync-folders"
alias umnt="qq-aliases-unmount"
alias dt="qq-aliases-dtach"
alias fs1="find . -type f -size +1M"

# out

alias trim1="sed 's/.$//'"
alias trim2="sed 's/..$//'"
alias trim3="sed 's/...$//'"
alias trim4="sed 's/....$//'"

# functions

qq-aliases-path-add() { echo "export PATH=\$PATH:$1" | tee -a ~/.zshrc }  
qq-aliases-make-dir-cd() { mkdir -p "$1" && cd "$1"; }      
qq-aliases-tail-grep-follow() { tail -f $1 | grep --line-buffered $2 }       
qq-aliases-replace-in-file() {print -z "sed 's/$1/$2/g' <file>"} #replace $1 with $2 in file
qq-aliases-sort-file-uniq() { cat $1 | sort -u -o $1 }  
qq-aliases-sort-file-uniq-ip() { cat $1 | sort -u | sort -V -o $1 } 
qq-aliases-dos-to-unix() { tr -d '\015' < $1 > $2 }
qq-aliases-unix-to-dos() { sed -e 's/$/\r/' $1 > $2 } 
qq-aliases-rsync-folders() { rsync -avu $1/ $2 }
qq-aliases-unmount() { fusermount -u $1 }

#network
qq-aliases-net-public-ip-curl() { curl icanhazip.com }     
qq-aliases-net-watch-netstat() { print -z "_ watch -n 0.3 'netstat -pantlu | grep \"ESTABLISHED\|LISTEN\"' "}
qq-aliases-net-ss() { print -z "_ ss -plunt" }
qq-aliases-net-lsof() { print -z "_ lsof -P -i -n "}

#usage
qq-aliases-sys-mem10() { print -z "_ ps aux | sort -rk 4,4 | head -n 10 | awk '{print \$4,\$11}' "}
qq-aliases-sys-disk10() { print -z "_ du -sk ./* | sort -r -n | head -10"}

qq-aliases-dtach() { dtach -A $1 /bin/zsh }
