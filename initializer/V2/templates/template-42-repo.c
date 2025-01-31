/* Big Header */

#pragma once
#ifndef TEMPLATE_42_REPO_C
# define TEMPLATE_42_REPO_C

# include "template-42-repo.h"

const t_template tmp_42_repo = {
	.name = "42-repo",
	.dirs = (t_dir[]) {
		{
			.name = "src",
			.path = "src",
			.files = (t_file[]) {
				{
					.name = "main.c",
					.path = "main.c",
					.content = CONTENT_MAIN_C
				},
			},
			.nb_files = 1
		},
		{
			.name = "includes",
			.path = "includes",
			.files = (t_file[]) {
				{
					.name = "main.h",
					.path = "main.h",
					.content = "CONTENT_MAIN_H"
				},
			},
			.nb_files = 1
		}
	},
	.nb_dirs = 2,
	.files = (t_file[]) {
		{
			.name = "Makefile",
			.path = "Makefile",
			.content = "CONTENT_MAKEFILE"
		},
		{
			.name = ".gitignore",
			.path = ".gitignore",
			.content = "CONTENT_GITIGNORE"
		}
	},
	.nb_files = 2
};

#endif	// TEMPLATE_42_REPO_H