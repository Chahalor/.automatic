#!/usr/bin/env bash

if [ "$#" -gt 0 ]; then
	cat "$@" | xclip -selection clipboard -in
else
	xclip -selection clipboard -in
fi