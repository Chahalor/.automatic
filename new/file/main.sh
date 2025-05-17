#!/bin/bash

JSON_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config.json"

# Lire le fichier JSON et extraire les champs
file=$(basename $1) || $(jq -r '.[0].header.file' "${JSON_FILE}") || "file"
author=$(jq -r '.[0].header.author' "${JSON_FILE}") || "author"
email=$(jq -r '.[0].header.email' "${JSON_FILE}") || "email"

main()
{
	{
		# Largeur cible pour l'alignement (ajuste si besoin)
		target_width=51
		file_len=${#file}
		spaces_needed=$((target_width - file_len))
		spaces=$(printf '%*s' "$spaces_needed" '')
		creation_date=$(date +"%Y/%m/%d %H:%M:%S")

		cat <<EOF
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ${file}${spaces}:+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ${author} <${email}>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: ${creation_date} by ${author}           #+#    #+#             */
/*                                                    ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */


#pragma region Header

/* -----| Internals |----- */
#include "_$(basename "$1").h"

/* -----| Modules   |----- */
#include "$(basename "$1").h"

#pragma endregion Header
#pragma region Fonctions



#pragma endregion Functions
EOF
	} > "$1"
}

main "$@"