#!/bin/bash

# This script pulls the latest changes from the remote repository and updates the local repository.
# Usage: ./pull.sh [branch_name] || pull [branch_name]

# Pull du dépôt principal avec submodules
git pull --recurse-submodules "$1"

# Init + update récursif
git submodule update --init --recursive

# Optionnel : forcer les submodules à se mettre à jour sur leurs branches distantes
git submodule update --recursive --remote
