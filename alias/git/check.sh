#!/bin/bash

# **************************************************************** #
# **************** Check conventional commit message ************* #
# **************************************************************** #
#
# Usage:
#   ./check.sh <commit message>
#
# Output:
#   stdout -> validated / completed commit message
#
# Examples:
#   ./check.sh "feat: add parser"
#       -> feat: add parser
#
#   ./check.sh "add parser"
#       -> opens commit type menu
#       -> feat: add parser
#
# Recommended usage:
#   MESSAGE="$(./check.sh "$MESSAGE")"
#
# Accepted formats:
#
#   type: message
#   type(scope): message
#

set -e

COMMIT_TYPES=(
	"feat"
	"fix"
	"refactor"
	"perf"
	"docs"
	"test"
	"build"
	"ci"
	"chore"
	"style"
	"revert"
)

MESSAGE="$*"

select_commit_type()
{
	local selected=0
	local key
	local rest
	local count=${#COMMIT_TYPES[@]}
	local tty="/dev/tty"
	local menu_lines=$((count + 1))

	restore_cursor()
	{
		tput cnorm > "$tty"
	}

	clear_menu()
	{
		# Move back to the first line of the menu
		printf '\033[%dA' "$menu_lines" > "$tty"

		# Clear every line used by the menu
		for ((i = 0; i < menu_lines; i++)); do
			printf '\r\033[2K' > "$tty"

			if (( i < menu_lines - 1 )); then
				printf '\033[1B' > "$tty"
			fi
		done

		# Move to the line directly after the old menu
		# printf '\033[1B\r' > "$tty"
		printf '\033[%dA' "$((menu_lines - 1))" > "$tty"
	}

	# Hide cursor
	tput civis > "$tty"

	trap 'restore_cursor; exit 130' INT TERM
	trap 'restore_cursor' EXIT

	while true; do
		printf "Select commit type:\n" > "$tty"

		for i in "${!COMMIT_TYPES[@]}"; do
			if (( i == selected )); then
				printf '\033[1;36m> %-10s\033[0m\n' \
					"${COMMIT_TYPES[$i]}" > "$tty"
			else
				printf '  %-10s\n' \
					"${COMMIT_TYPES[$i]}" > "$tty"
			fi
		done

		IFS= read -rsn1 key < "$tty"

		if [[ "$key" == $'\x1b' ]]; then
			IFS= read -rsn2 rest < "$tty"
			key+="$rest"
		fi

		case "$key" in
			$'\x1b[A')
				(( selected-- )) || true

				if (( selected < 0 )); then
					selected=$((count - 1))
				fi
				;;

			$'\x1b[B'|$'\t')
				(( selected++ )) || true

				if (( selected >= count )); then
					selected=0
				fi
				;;

			'')
				break
				;;
		esac

		printf '\033[%dA' "$((count + 1))" > "$tty"
	done

	SELECTED_TYPE="${COMMIT_TYPES[$selected]}"

	restore_cursor
	clear_menu
	trap - INT TERM EXIT
}

if [[ -z "$MESSAGE" ]]; then
	echo "no commit message" >&2
	exit 1
fi

COMMIT_PATTERN='^[[:alnum:]_-]+(\([^()]+\))?:[[:space:]]+.+$'

if [[ "$MESSAGE" =~ $COMMIT_PATTERN ]]; then
	printf '%s\n' "$MESSAGE"
	exit 0
fi

select_commit_type

printf '%s: %s\n' "$SELECTED_TYPE" "$MESSAGE"