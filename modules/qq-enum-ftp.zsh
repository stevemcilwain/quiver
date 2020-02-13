#!/usr/bin/env zsh

############################################################# 
# Enum - FTP
#############################################################

qq-enum-ftp-sweep-nmap() {
  local s && read "s?Subnet (range): "
  print -z "nmap -n -Pn -sS -p21 -oA ftp_sweep ${s} && \
    grep open ftp_sweep.gnmap |cut -d' ' -f2 > sweep.${s}.txt"
}

qq-enum-ftp-tcpdump() {
  local i && read "i?Interface: "
  local r && read "r?RHOST: "
  print -z "tcpdump -i ${i} host ${r} and tcp port 21 -w capture.${r}.pcap"
}

qq-enum-ftp-brute-hydra() {
  local r && read "r?RHOST: "
  local u && read "u?Username: "
  print -z "hydra -l ${u} -P ${__PASS_ROCKYOU} -f ${r} ftp -V -t 15"
}

qq-enum-ftp-lftp-grep() {
  local r && read "r?RHOST: "
  print -z "lftp ${r}:/ > find | grep "
}

qq-enum-ftp-wget-mirror() {
  local r && read "r?RHOST: "
  print -z "wget --mirror ftp://anonymous:user@anon.com@${r}"
}
