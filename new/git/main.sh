#!/bin/bash

# This script is used to create a new git repository and initialize it with a README.md, a .gitignore and a TODO.md files.

# Usage: ./main.sh <repository_name> <language>
# version: 0.0

main()
{
	dir="$1"
	git init "$dir"
	cd "$dir" || {echo "failed to creat the git repository"; exit 1}
	echo "Creating a new git repository: ${dir}..."
	touch README.md .gitignore TODO.md
	echo "Module $1 created successfully."
}