#!/bin/bash

# **************************************************************** #
# ****** add and commit the current all currents changes ********* #
# **************************************************************** #
#  - Version: 2.1.1
#  - Usage: ./commit.sh <commit message>

set -e

MESSAGE="$1"

if [ -z "${MESSAGE}" ]; then
	echo "no commit message, please add one"
	exit 1
fi

git status


# Auto-clean build files if Makefile exists
if [[ -f "Makefile" || -f "makefile" ]]; then
	echo "Running make fclean..."
	make fclean || true
fi

git add .
git commit -m "${MESSAGE}"