#!/bin/bash

# *********************************************************** #
# ****** Push the current branch to the remote repo ********* #
# *********************************************************** #
#  - Version: 2.0
#  - Usage: ./push.sh [commit message] || push [commit message]

# Exit if any command fails
set -e

# Auto-clean build files if Makefile exists
if [[ -f "Makefile" || -f "makefile" ]]; then
	echo "Running make fclean..."
	make fclean
fi

# Stage all changes
git add -A

# Commit message
if [ -z "$1" ]; then
	COMMIT_MSG="auto push"
else
	COMMIT_MSG="$1"
fi

# Check for staged changes before committing
if git diff --cached --quiet; then
	echo "No changes to commit."
else
	echo "Committing changes: $COMMIT_MSG"
	git commit -m "$COMMIT_MSG"
fi

# Push to current branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Pushing to branch: $BRANCH"
git push origin "$BRANCH"


# #!/bin/bash

# # *********************************************************** #
# # ******Push the current branch to the remote repository***** #
# # *********************************************************** #


# if [[ -f "Makefile" || -f "makefile" ]]; then
# 	make fclean
# fi

# git add .

# if [ -z "$1" ]; then
# 	git commit -m "auto push"
# else
# 	git commit -m "$1"
# fi

# git push
