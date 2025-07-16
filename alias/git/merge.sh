#!/bin/bash

# *********************************************************** #
# ******** Automatic git merger with rebase support ********* #
# *********************************************************** #
#  - Version: 2.0
#  - Usage: ./merger.sh [commit message] || merge [commit message]

# Exit immediately on errors
set -e

# Stage all changes
git add -A

# Determine commit message
if [ -z "$1" ]; then
	COMMIT_MSG="Auto commit"
else
	COMMIT_MSG="$1"
fi

# Commit only if there are staged changes
if git diff --cached --quiet; then
	echo "No changes to commit."
else
	echo "Committing changes: $COMMIT_MSG"
	git commit -m "$COMMIT_MSG"
fi

# Get current branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Pull with rebase to avoid merge commits
echo "Rebasing latest changes from origin/$BRANCH..."
git pull --rebase origin "$BRANCH"

# Push changes
echo "Pushing to origin/$BRANCH..."
git push origin "$BRANCH"
