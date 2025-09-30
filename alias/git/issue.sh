#!/bin/bash

# *********************************************************** #
# ****** create a new issue in the repository       ********* #
# *********************************************************** #
#  - Version: 0.0.1
#  - Usage: ./issue.sh [issue title] [issue body]

# Exit if any command fails
set -e

# Vérification des arguments
if [ $# -lt 3 ]; then
	echo "Usage: $0 <flag> <title> <content>"
	exit 1
fi

GITHUB_TOKEN=$(jq -r '.alias.git.issue.GITHUB_TOKEN' "$AUTOMATIC_PATH/config.json")

FLAG="$1"
TITLE="$2"
CONTENT="$3"

# Récupérer l'URL du repo courant
REPO_URL=$(git config --get remote.origin.url)

if [[ "$REPO_URL" =~ github.com[:/](.+)/(.+).git ]]; then
	OWNER="${BASH_REMATCH[1]}"
	REPO="${BASH_REMATCH[2]}"
else
	echo "Erreur : Impossible de déterminer le repo GitHub à partir de remote.origin.url"
	exit 1
fi

# Définir le label en fonction du flag
case "$FLAG" in
	-b|--bug)
		LABEL="bug"
		;;
	-f|--feature)
		LABEL="feature"
		;;
	*)
		LABEL="general"
		;;
esac

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