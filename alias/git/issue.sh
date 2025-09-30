#!/bin/bash

# *********************************************************** #
# ****** create a new issue in the repository       ********* #
# *********************************************************** #
#  - Version: 2.1.0
#  - Usage: ./issue.sh <action: open/close>
#						- close <issue_number>
#						- open [<issue_number> or <title> <content> <labels>]

# Exit if any command fails
set -e

function print_usage()
{
	echo "Usage: $0 <action: open/close>"
	echo "  - open [<issue_number> or <title> <content> <labels>]"
	echo "  - close <issue_number>"
	exit 1
}

function check_token()
{
	if [ -z "$GITHUB_TOKEN" ]; then
		echo "Error: GITHUB_TOKEN is not set. Please set it in $AUTOMATIC_PATH/config.json: 'alias.git.issue.GITHUB_TOKEN'."
		exit 1
	fi
}

function action_open()
{
	TITLE="$1"
	CONTENT="$2"
	LABEL="$3"

	check_token

	# Create issue via GitHub API
	curl -s -X POST \
		-H "Authorization: token $GITHUB_TOKEN" \
		-H "Accept: application/vnd.github.v3+json" \
		"https://api.github.com/repos/$OWNER/$REPO/issues" \
		-d "$(jq -n --arg t "$TITLE" --arg b "$CONTENT" --arg l "$LABEL" '{title:$t, body:$b, labels:[$l]}')"

	echo "Issue '$TITLE' created with label '$LABEL'."
}

function action_reopen()
{
	ISSUE_NUMBER="$1"

	check_token

	curl -s -X PATCH \
		-H "Authorization: token $GITHUB_TOKEN" \
		-H "Accept: application/vnd.github.v3+json" \
		"https://api.github.com/repos/$OWNER/$REPO/issues/$ISSUE_NUMBER" \
		-d '{
			"state": "open"
		}'
	echo "Issue #$ISSUE_NUMBER opened."
}

function action_close()
{
	ISSUE_NUMBER="$1"

	check_token

	curl -s -X PATCH \
		-H "Authorization: token $GITHUB_TOKEN" \
		-H "Accept: application/vnd.github.v3+json" \
		"https://api.github.com/repos/$OWNER/$REPO/issues/$ISSUE_NUMBER" \
		-d '{
			"state": "closed"
		}'
	echo "Issue #$ISSUE_NUMBER closed."
}

ACTION="$1"

case "$ACTION" in
	"open")
		;;
	"close")
		;;
	*)
		print_usage
		;;
esac

if [ "$ACTION" == "open" ]; then
	ARG2="$2"
	LAST_ARG="${!#}"

	if [ $# -eq 2 ] && [[ "$ARG2" =~ ^[0-9]+$ ]]; then
		ACTION="reopen"
	elif [ $# -lt 4 ]; then
		echo "Usage: $0 open <title> <content> <labels>"
		exit 1
	else
		TITLE="$2"
		CONTENT="$3"
		LABELS="$4"
	fi
elif [ "$ACTION" == "close" ]; then
	if [ $# -lt 2 ]; then
		echo "Usage: $0 close <issue_number>"
		exit 1
	fi
	ISSUE_NUMBER="$2"
else
	echo "Usage: $0 <action: open/close>"
	exit 1
fi

GITHUB_TOKEN=$(jq -r '.alias.git.issue.GITHUB_TOKEN' "$AUTOMATIC_PATH/config.json")

# get repo info from git config
REPO_URL=$(git config --get remote.origin.url)

if [[ "$REPO_URL" =~ github.com[:/](.+)/(.+).git ]]; then
	OWNER="${BASH_REMATCH[1]}"
	REPO="${BASH_REMATCH[2]}"
else
	echo "Error: Unable to determine GitHub repo from remote.origin.url"
	exit 1
fi

# Execute action
if [ "$ACTION" == "open" ]; then
	action_open "$TITLE" "$CONTENT" "$LABELS"
elif [ "$ACTION" == "close" ]; then
	action_close "$ISSUE_NUMBER"
elif [ "$ACTION" == "reopen" ]; then
	action_reopen "$ARG2"
else
	print_usage
fi
