#!/usr/bin/env bash

xfconf-query -c xfwm4 -p /general/theme -s Kali-Dark-xHiDPI
xfconf-query -c xsettings -p /Gdk/WindowScalingFactor -n -t 'int' -s 2
cat <<- EOF >> ~/.xsessionrc
	export QT_SCALE_FACTOR=2
	export XCURSOR_SIZE=48
	export GDK_SCALE=2
EOF