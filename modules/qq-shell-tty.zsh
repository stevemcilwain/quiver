#!/usr/bin/env zsh

############################################################# 
# qq-shell-tty
#############################################################

qq-shell-tty-help() {
  cat << "DOC"

qq-shell-tty
------------
The shell-tty namespace provides commands for fixing interactive 
command/reverse shells.

Commands
--------
qq-shell-tty-python2:     command to spawn a tty shell
qq-shell-tty-python3:     command to spawn a tty shell     
qq-shell-tty-perl:        command to spawn a tty shell
qq-shell-tty-ruby:        command to spawn a tty shell
qq-shell-tty-lua:         command to spawn a tty shell
qq-shell-tty-expect:      command to spawn a tty shell

DOC
}

qq-shell-tty-python2() {
    __ok "Copy the commands below and use on the remote system"
    cat << "DOC" 

python -c 'import pty;pty.spawn("/bin/sh")' 

DOC
}

qq-shell-tty-python3() {
    __ok "Copy the commands below and use on the remote system"
    cat << "DOC" 

python3 -c 'import pty;pty.spawn("/bin/sh")'

DOC
}

qq-shell-tty-perl() {
    __ok "Copy the commands below and use on the remote system"
    cat << "DOC" 

perl -e 'exec "/bin/sh";'

DOC
}

qq-shell-tty-ruby() {
    __ok "Copy the commands below and use on the remote system"
    cat << "DOC" 

ruby: exec "/bin/sh"

DOC
}

qq-shell-tty-lua() {
    __ok "Copy the commands below and use on the remote system"
    cat << "DOC" 

lua: os.execute('/bin/sh')

DOC
}

qq-shell-tty-expect() {
    __ok "Copy the commands below and use on the remote system"
    cat << "DOC" 

/usr/bin/expect sh

DOC
}
