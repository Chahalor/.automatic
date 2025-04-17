#!/bin/bash

# This script pulls the latest changes from the remote repository and updates the local repository.
# Usage: ./pull.sh [branch_name] || pull [branch_name]

git pull --recurse-submodules $1
git submodule update --recursive --remote