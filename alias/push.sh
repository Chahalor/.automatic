#!/bin/bash

# *********************************************************** #
# ******Push the current branch to the remote repository***** #
# *********************************************************** #

git add .

if [ -z "$1" ]; then
	git commit -m "auto push"
else
	git commit -m "$1"
fi

git push
