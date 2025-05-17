#!/bin/bash

# *********************************************************** #
# ********       Automatic creation of things       ********* #
# *********************************************************** #
#  - Version: 1.0
#  - Author: nduvoid <nduvoid@student.42mulhouse.fr>
#  - Usage: ./new.sh [type] [name] || new [type] [name]

# Constants
authors="nduvoid <nduvoid@student.42mulhouse.fr>"
version="1.0"

# Variables
OPTIONS=""
SCRIPT_DIR=""

# Utils

help()
{
	echo "Usage: ./new.sh [type] [name] || new [type] [name]"
	echo "Description:"
	echo "  This script creates a new thing based on the specified type and name."

	echo "Options:"
	echo "  -h  Show this help message"
	echo "  -v  Show version information"

	echo "Available types:"
	for arg in ${OPTIONS}; do
		echo "  - ${arg}"
	done
	echo "Examples:"
	echo "  new project my_project"
	echo "  new module my_module"
	echo "  new file main.c"

	echo "Author:"
	for arg in ${authors}; do
		echo "  - ${arg}"
	done
}

# Core

find_options()
{
	SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	OPTIONS=$(find "${SCRIPT_DIR}" -mindepth 1 -maxdepth 1 -type d | sed 's|.*/||')
	OPTIONS=$(echo "${OPTIONS}" | tr '\n' ' ')
}

parser()
{
	while getopts "hv" opt; do
		case $opt in
			h) help; exit 0 ;;
			v) echo "Version: 0.1"; exit 0 ;;
			\?) echo "Invalid option: -$OPTARG" >&2 ;;
		esac
	done
}

main()
{
	find_options
	parser "$@"
	for arg in "$@"; do
		if [[ ${arg} == -* ]]; then
			continue
		fi
		for option in ${OPTIONS}; do
			if [[ ${arg} == ${option} ]]; then
				bash "${SCRIPT_DIR}/${option}/main.sh" ${@:2} || { echo "  Failed to create ${option}"; exit 1; }
				exit 0
			fi
		done
	done
}

main "$@"