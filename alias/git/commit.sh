#!/bin/bash

# **************************************************************** #
# ****** add and commit all current changes ********************** #
# **************************************************************** #
#  - Version: 1.2.0
#  - Usage: ./commit.sh <commit message>
#
# Conventional commit format:
#
#   type: message
#   type(scope): message

set -e

BOLD=$'\033[1m'
BLUE=$'\033[34m'
RESET=$'\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MESSAGE="$*"

if [[ -z "$MESSAGE" ]]; then
	echo "no commit message, please add one"
	exit 1
fi

MESSAGE="$("$SCRIPT_DIR/check.sh" "$MESSAGE")"

git status

printf "commit message: '%s%s%s%s'\n" "$BOLD" "$BLUE" "$MESSAGE" "$RESET"

if git diff --quiet \
	&& git diff --cached --quiet \
	&& [[ -z "$(git ls-files --others --exclude-standard)" ]]; then
	echo "✅ no changes to commit"
	exit 0
fi

read -rp "Press [Enter] to continue or Ctrl+C to abort..."

git add .
git commit -m "$MESSAGE"
