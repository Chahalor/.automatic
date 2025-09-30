#!/bin/bash

# *********************************************************** #
# ****** create a new issue in the repository       ********* #
# *********************************************************** #
#  - Version: 2.0.0
#  - Usage: ./issue.sh <action: open/close>
#						- close <issue_number>
#						- open <title> <content> <labels>

# Exit if any command fails
set -e

function print_usage()
{
	echo "Usage: $0 <action: open/close>"
	echo "  - open <title> <content> <labels>"
	echo "  - close <issue_number>"
	exit 1
}

function action_open()
{
	TITLE="$1"
	CONTENT="$2"
	LABEL="$3"

	# Token GitHub depuis variable d'environnement
	if [ -z "$GITHUB_TOKEN" ]; then
		echo "Error: GITHUB_TOKEN is not set. Please set it in $AUTOMATIC_PATH/config.json: 'alias.git.issue.GITHUB_TOKEN'."
		exit 1
	fi

	# Création de l'issue via API GitHub
	curl -s -X POST \
		-H "Authorization: token $GITHUB_TOKEN" \
		-H "Accept: application/vnd.github.v3+json" \
		"https://api.github.com/repos/$OWNER/$REPO/issues" \
		-d "$(jq -n --arg t "$TITLE" --arg b "$CONTENT" --arg l "$LABEL" '{title:$t, body:$b, labels:[$l]}')"

	echo "Issue '$TITLE' créée avec le label '$LABEL'."
}

function action_close()
{
	ISSUE_NUMBER="$1"

	if [ -z "$GITHUB_TOKEN" ]; then
		echo "Error: GITHUB_TOKEN is not set. Please set it in $AUTOMATIC_PATH/config.json: 'alias.git.issue.GITHUB_TOKEN'."
		exit 1
	fi

	curl -s -X PATCH \
		-H "Authorization: token $GITHUB_TOKEN" \
		-H "Accept: application/vnd.github.v3+json" \
		"https://api.github.com/repos/$OWNER/$REPO/issues/$ISSUE_NUMBER" \
		-d '{
			"state": "closed"
		}'
	echo "Issue #$ISSUE_NUMBER fermée."

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

# Vérification des arguments
if [ "$ACTION" == "open" ]; then
	if [ $# -lt 4 ]; then
		echo "Usage: $0 open <title> <content> <labels>"
		exit 1
	fi
	TITLE="$2"
	CONTENT="$3"
	LABELS="$4"
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

# Récupérer l'URL du repo courant
REPO_URL=$(git config --get remote.origin.url)

if [[ "$REPO_URL" =~ github.com[:/](.+)/(.+).git ]]; then
	OWNER="${BASH_REMATCH[1]}"
	REPO="${BASH_REMATCH[2]}"
else
	echo "Erreur : Impossible de déterminer le repo GitHub à partir de remote.origin.url"
	exit 1
fi

# Exécuter l'action
if [ "$ACTION" == "open" ]; then
	action_open "$TITLE" "$CONTENT" "$LABELS"
elif [ "$ACTION" == "close" ]; then
	action_close "$ISSUE_NUMBER"
fi
