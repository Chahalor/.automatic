#!/bin/bash

main()
{
	if [[ -d "$1" ]]; then
		echo "Directory $1 already exists. Please choose a different name."
		exit 1
	fi

	dir="$1"
	echo "Creating a new module: ${dir}..."
	mkdir -p "${dir}" "${dir}/_internal"
	touch "${dir}/$(basename ${dir}).c" "${dir}/$(basename ${dir}).h" "${dir}/_internal/_$(basename ${dir}).c" "${dir}/_internal/_$(basename ${dir}).h"
	echo "Module $1 created successfully."

	if [[ -f Makefile || -f makefile ]]; then
		echo "Updating Makefile..."
		make update
	fi
}

main "$@"