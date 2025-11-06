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
if git diff --quiet && git diff --cached --quiet && [[ -z $(git ls-files --others --exclude-standard) ]] && git log origin/$(git rev-parse --abbrev-ref HEAD)..HEAD --oneline | grep -q '^$'; then
	echo "✅ no changes to commit"
	exit 0
else
	read -p "Press [Enter] to continue or Ctrl+C to abort..."
fi

# Auto-clean build files if Makefile exists
if [[ -f "Makefile" || -f "makefile" ]]; then
	echo "Running make fclean..."
	make fclean || true
fi

git add .
git commit -m "${MESSAGE}"