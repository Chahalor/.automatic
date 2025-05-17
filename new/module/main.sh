#!/bin/bash

main()
{
	if [[ -d "$1" ]]; then
		echo "Directory $1 already exists. Please choose a different name."
		exit 1
	fi

	echo "Creating a new module: $1"
	mkdir -p "$1" "$1/_internal"
	touch "$1/$1.c" "$1/$1.h" "$1/_internal/_$1.c" "$1/_internal/_$1.h"
	echo "Module $1 created successfully."

	if [[ -f Makefile || -f makefile ]]; then
		echo "Updating Makefile..."
		make -C "$1" update
	fi
}

main "$@"