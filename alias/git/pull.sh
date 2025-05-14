#!/bin/bash

# This script pulls the latest changes from the remote repository and updates the local repository.
# Usage: ./pull.sh [init|all|help] [path] or pull [init|all|help] [path]
# Version: 2.0

MODE="default"
TARGET_PATH="."

# Parse the first argument
case "$1" in
	-h|--help|help)
		echo "Usage: $0 [init|all|help] [path]"
		echo ""
		echo "Options:"
		echo "	init     Initialize submodules after pull"
		echo "	all      Initialize and update submodules recursively and remotely"
		echo "	help     Show this help message"
		exit 0
		;;
	"init")
		MODE="init"
		shift
		;;
	"all")
		MODE="all"
		shift
		;;
	"")
		MODE="default"
		;;
	*)
		echo "Unsupported option: $1"
		exit 1
		;;
esac

# Set target path if provided
if [ -n "$1" ]; then
	TARGET_PATH="$1"
fi

echo "Pulling from $TARGET_PATH with mode $MODE"

cd "$TARGET_PATH" || { echo "Error: cannot change to directory $TARGET_PATH"; exit 1; }

case "$MODE" in
	"all")
		git pull --recurse-submodules || exit 1
		[ -f .gitmodules ] && git submodule update --init --recursive
		[ -f .gitmodules ] && git submodule update --recursive --remote
		;;
	"init")
		git pull --recurse-submodules || exit 1
		[ -f .gitmodules ] && git submodule update --init --recursive
		;;
	*)
		git pull || exit 1
		;;
esac
