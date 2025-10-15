#!/bin/sh

FILENAME="$1"

if [ -z "$FILENAME" ]; then
	echo "Usage: $0 <filename>"
	exit 1
fi

touch "${FILENAME}.cpp" "${FILENAME}.hpp"
echo "Created ${FILENAME}.cpp and ${FILENAME}.hpp"
