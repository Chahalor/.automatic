/* Big Header */

#ifndef INITIALIZER_H
# define INITIALIZER_H

/* -----| Headers |----- */
// Global
# include <stdlib.h>
# include <stdio.h>
# include <unistd.h>
# include <string.h>
# include <sys/stat.h>

// Local
//...

// Template
# include "template-42-repo.h"

/* -----| Macros |----- */
//...

/* -----| Typedef |----- */
//...

/* -----| Enums |----- */

typedef enum e_bool
{
	FALSE,
	TRUE
}	t_bool;

typedef enum e_error
{
	no_error,
	invalid_option,
	invalide_argument,
	unknown_template,
	file_error,
	alloc_error,
	invalid_arg,
}	t_error;

/* -----| Union |----- */
//...

/* -----| Structs |----- */

/** @todo */
typedef struct s_args
{
	int	argc;
	char	**argv;
	const char	*path;
	t_bool		help		: 2;
	t_bool		invalide	: 2;
}	t_args;

typedef struct s_file
{
	char	name[265];
	char	path[1024];
	char	*content;
}	t_file;

typedef struct s_dir
{
	char	name[265];
	char		path[1024];
	t_file		*files;
	int			nb_files;
}	t_dir;

typedef struct s_template
{
	int		nb_dirs;
	int		nb_files;
	char	*name;
	char	*path;
	t_dir	*dirs;
	t_file	*files;
}			t_template;


/* -----| Prototypes |----- */
//...

#endif	// INITIALIZER_H
