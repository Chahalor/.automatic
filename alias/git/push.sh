#!/bin/bash

# *********************************************************** #
# ****** Push the current branch to the remote repo ********* #
# *********************************************************** #
#  - Version: 2.2.1
#  - Usage: ./push.sh [commit message] || push [commit message]
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
	git push
	exit 0
fi

if git diff --quiet && git diff --cached --quiet && [[ -z $(git ls-files --others --exclude-standard) ]] && git log origin/$(git rev-parse --abbrev-ref HEAD)..HEAD --oneline | grep -q '^$'; then
	echo "✅ no changes to push"
	exit 0
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
BRANCH=$(git rev-parse --abbrev-ref HEAD)
printf "Pushing to branch: %s%s%s%s\n" "$BOLD" "$BLUE" "$BRANCH" "$RESET"
git push origin "$BRANCH"
