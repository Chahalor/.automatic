#!/bin/bash

# colors
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[1;33m'
RESET='\e[0m'

# Global Var
VERSION="0.1"
CREDITS="nduvoid"

# File and Dir List
list_dir=("includes" "src" ".test")
list_file=(".gitignore" "TODO.md" "makefile")
list_languages=('C')
templates_path=/home/nduvoid/Desktop/connerie/.automatic/template

# File Content
# None...

# options
bonus=0
credits=0
debug=0
help=0
language=""
quiet=0
version=0

# Error manager
cp_output=0
nb_err_dir=0
nb_err_file=0
nb_err_bonus=0

# Exit Code
exit_help=1

# Options manager
while getopts "bcdhlqv" opt; do
	case $opt in
		b)
			bonus=1
			;;
		c)
			credits=1
			;;
		d)
			debug=1
			;;
		h)
			help=1
			;;
		l)
			language=$OPTARG
			;;
		q)
			quiet=1
			;;
		v)
			version=1
			;;
		\?)
			echo -e "$RED Invalid option:$RESET -$OPTARG ❌" >&2
			;;
	esac
done

# ├── └── │ ┌─ └─ ┬ ├ │ ┐
# Options display
if [ "$quiet" -eq 1 ]; then
	exec 1>/dev/null
fi
if [ "$version" -eq 1 ]; then
	echo -e "$YELLOW Version: $VERSION $RESET 🔖"
fi
if [ "$credits" -eq 1 ]; then
	echo -e "$YELLOW Credits: $CREDITS $RESET 👨‍💻"
fi
if [ "$debug" -eq 1 ]; then
	echo -e "$YELLOW Debug mode $RESET 🪳"
	set -x
fi
if [ "$help" -eq 1 ]; then
	echo -e "$YELLOW Help $RESET 📚"
	echo -e "├── -b: Ad bonus files"
	echo -e "├── -c: Credits"
	echo -e "├── -d: Debug mode"
	echo -e "├── -h: Help"
	echo -e "├── -l: Language of the template"
	echo -e "├── -q: Quiet mode"
	echo -e "└── -v: Version"
	exit "$exit_help"
fi
if [ "$language" != "" ]; then
	echo -e "$YELLOW Language: $language $RESET 🌐"
	echo -e "$YELLOW Language not supported in this version $RESET ❌"
fi


# Functions
write_file()
{
	file=$1
	i=$2
	doc=$3
	success=$4
	color=""

	if [ "$success" -eq 1 ]; then
		if [ "$i" -eq "$(($doc - 1))" ]; then
			echo -e "$YELLOW└── $file $RESET"
		else
			echo -e "$YELLOW├── $file $RESET"
		fi
	else
		if [ "$i" -eq "$(($doc - 1))" ]; then
			echo -e "$YELLOW└──┐$RED Fail to create $file $RESET"
		else
			echo -e "$YELLOW├──┐$RED Fail to create $file $RESET"
		fi
		echo -e "  $YELLOW └──$RESET $cp_output"
		((nb_err_dir++));
	fi
}

create_file()
{
	path=$1
	files=($(ls -A "$path"))
	i=0
	for doc in "${files[@]}"; do
		cp -r "$path/$doc" "$doc"
		cp_output=$?
		if [ "$cp_output" -ne 0 ]; then
			write_file "$cp_output" "$i" "${#files[@]}" 0
		else 
			write_file "$doc" "$i" "${#files[@]}" 1
		fi
		((i++))
	done
}

# Main
echo -e "⚙️ $YELLOW directory creation $RESET ⚙️"

create_file "$templates_path"

if [ "$nb_err_dir" -gt 0 ]; then
	echo -e "$RED $nb_err_dir/TODO File creation Fail $RESET ❌"
else
	echo -e "$GREEN TODO File create with success $RESET ✅";
fi

echo ""
echo -e "$GREEN Repository initialized $RESET ✅"
