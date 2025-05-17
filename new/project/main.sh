#!/bin/bash

NAME=$1
DIR_SRC="src"
DIR_GLOBAL="global"
DIR_DEV=".dev"

main()
{
	if [ -z "$NAME" ]; then
		echo "Error: No name provided."
		exit 1
	elif [ -d "$NAME" ]; then
		echo "Error: Directory $NAME already exists."
		exit 1
	fi
	echo "Creating a new project: ${NAME}"
	mkdir -p "${NAME}"
	cd "${NAME}" || { echo "Failed to enter directory ${NAME}"; exit 1; }
	mkdir "$DIR_SRC" "$DIR_GLOBAL" "$DIR_DEV"
	touch "${DIR_SRC}/main.c" "${DIR_DEV}/config.h" "README.md" "Makefile" "${DIR_DEV}/TODO.md"
	SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	cp "${SCRIPT_DIR}/auto.sh" "./auto.sh"
	bash "${SCRIPT_DIR}/auto.sh"
	echo "Project ${NAME} created successfully."
}

main "$@"