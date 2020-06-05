#!/usr/bin/env bash

apt update
apt -y install wget gnupg dirmngr

wget -q -O - https://archive.kali.org/archive-key.asc | gpg --import
gpg --keyserver hkp://keys.gnupg.net --recv-key 44C6513A8E4FB3D30875F758ED444FF07D8D0BF6

mv /etc/apt/sources.list /etc/apt/sources.list.debian

echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list

gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -


apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y autoremove --purge
apt-get clean