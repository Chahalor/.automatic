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
templates_path=/home/nduvoid/.automatic/template

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
# ├── └── │ ┌─ └─ ┬ ├ │
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


# Main
echo -e "⚙️ $YELLOW directory creation $RESET ⚙️"
for i in "${!list_dir[@]}"; do
	cp -r "$templates_path/${list_dir[$i]}" "${list_dir[$i]}"
	cp_output=$?
	if [ "$cp_output" -ne 0 ]; then
		echo -e "$RED Fail to create ${list_dir[$i]} $RESET ❌"
		if [debug -eq 1]; then
			echo -e "	$cp_output"
		((nb_err_dir++));
	fi
	elif [ "$i" -eq "$((${#list_dir[@]} - 1))" ]; then
		echo -e "$YELLOW└── /${list_dir[$i]} $RESET"
	else
		echo -e "$YELLOW├── /${list_dir[$i]} $RESET"
	fi
done

if [ "$nb_err_dir" -gt 0 ]; then
	echo -e "$RED $nb_err_dir/${#list_dir[@]} directory failed to create $RESET ❌"
else
	echo -e "$GREEN ${#list_dir[@]}/${#list_dir[@]} Directory create with success $RESET ✅";
fi


echo -e "⚙️ $YELLOW File creation $RESET ⚙️"
for i in "${!list_file[@]}"; do
	cp "$templates_path/${list_file[$i]}" "${list_file[$i]}"
	cp_output=$?
	if [ "$cp_output" -ne 0 ]; then
		echo -e "$RED Fail to create ${list_file[$i]} $RESET ❌"
		if [debug -eq 1]; then
			echo -e "	$cp_output"
		((nb_err_file++));
	fi
	elif [ "$i" -eq "$((${#list_file[@]} - 1))" ]; then
		echo -e "$YELLOW└── ${list_file[$i]} $RESET"
	else
		echo -e "$YELLOW├── ${list_file[$i]} $RESET"
	fi
done

if [ "$nb_err_file" -gt 0 ]; then
	echo -e "$RED $nb_err_file/${#list_file[@]} file failed to create $RESET ❌"
else
	echo -e "$GREEN ${#list_file[@]}/${#list_file[@]} File create with success $RESET ✅";
fi

if [ "$bonus" -eq 1 ]; then
	echo -e "⚙️ $YELLOW Bonus file creation $RESET ⚙️"
	cp -r "$templates_path/'src bonus'" 'src bonus'
	cp_output=$?
	if [ "$cp_output" -ne 0 ]; then
		echo -e "$RED Fail to create bonus dir $RESET ❌"
		if [debug -eq 1]; then
			echo -e "	$cp_output"
		fi
		((nb_err_bonus++));
	fi
	cp "$templates_path/'includes bonus'" 'includes bonus'
	cp_output=$?
	if [ "$cp_output" -ne 0 ]; then
		echo -e "$RED Fail to create bonus dir $RESET ❌"
		if [debug -eq 1]; then
			echo -e "	$cp_output"
		fi
		((nb_err_bonus++));
	fi
	if [ "$nb_err_bonus" -gt 0 ]; then
		echo -e "$RED $nb_err_bonus/2 bonus file failed to create $RESET ❌"
	else
		echo -e "$GREEN Bonus file created with success $RESET ✅"
	fi
fi

echo ""
echo -e "$GREEN Repository initialized $RESET ✅"
