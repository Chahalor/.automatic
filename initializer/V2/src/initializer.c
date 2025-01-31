/* Big Header */

#include "initializer.h"

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
					.content = "#include <stdio.h>\n\nint main(int argc, char **argv)\n{\n\tprintf(\"Hello, World!\\n\");\n\treturn (0);\n}"
				}
			},
			.nb_files = 1
		},
		{
			.name = "includes",
			.path = "includes",
			.files = (t_file[]) {
				{
					.name = "main.h",
					.path = "main.h"
				}
			},
			.nb_files = 1
		}
	},
	.nb_dirs = 2,
	.files = (t_file[]) {
		{
			.name = "Makefile",
			.path = "Makefile",
			.content = "CC = gcc\nCFLAGS = -Wall -Wextra -Werror\n\nSRC = $(wildcard src/*.c)\nOBJ = $(SRC:.c=.o)\n\nNAME = a.out\n\nall: $(NAME)\n\n$(NAME): $(OBJ)\n\t$(CC) $(CFLAGS) -o $@ $^\n\nclean:\n\trm -f $(OBJ)\n\nfclean: clean\n\trm -f $(NAME)\n\nre: fclean all\n\n.PHONY: all clean fclean re"
		},
		{
			.name = ".gitignore",
			.path = ".gitignore",
			.content = "*.o\n*.out\n.vscode\n.test\n.obj\n*.dSYM\n*.DS_Store\n*.swp"
		}
	},
	.nb_files = 2
};

/** @todo */
void	exiting(const int code, const char *message, void *ptr)
{
	if (ptr)
		free(ptr);
	if (message)
		perror(message);
	exit(code);
}

/** @todo */
void	handle_short_option(t_args *args, int *index, const char *arg)
{
	(void)index;
	if (arg[0] != '-' || arg[1] == '\0' || arg[2] != '\0')
	{
		args->invalide = TRUE;
		return ;
	}
	switch (arg[1])
	{
	case 'h':
		args->help = TRUE;
		break;
	default:
		args->invalide = TRUE;
		break;
	}
}

/** @todo */
void	handle_long_option(t_args *args, int *index, const char *arg)
{
	(void)index;
	if (arg[0] != '-' || arg[1] != '-' || arg[2] == '\0')
	{
		args->invalide = TRUE;
		return ;
	}
	if (strcmp(arg, "--help") == 0)
		args->help = TRUE;
	else
		args->invalide = TRUE;
}

/** @todo */
t_args	*handler_args(int argc, char **argv)
{
	t_args	*args = NULL;
	int		i = -1;

	args = (t_args *)malloc(sizeof(t_args));
	if (!args)
		return (NULL);

	args->argc = argc;
	args->argv = argv;
	args->path = argv[0];
	args->help = FALSE;
	args->invalide = FALSE;

	while (++i < argc)
	{
		if (argv[i][0] == '-')
		{
			if (argv[i][1] == '-')
				handle_long_option(args, &i, argv[i]);
			else
				handle_short_option(args, &i, argv[i]);
		}
	}
	return (args);
}

// ├── └── │ ┌─ └─ ┬ ├ │ ┐
/** @todo */
void	template_builder(t_args *args, const char *name, t_template templates)
{
	int		i_dir = -1;
	int		i_file = -1;
	char	path[4096] = {'\0'};

	if (strcmp(name, "42-repo") != 0)
		exiting(unknown_template, "unknown template", args);
	
	printf("Creating template: %s\n", name);
	while (++i_dir < templates.nb_dirs)
	{
		memset(path, 0, 4096);
		strcpy(path, templates.dirs[i_dir].path);
		strcat(path, "/");
		mkdir(path, 0755);
		printf("├──Creating directory: %s\n", path);
		i_file = -1;
		while (++i_file < templates.dirs[i_dir].nb_files)
		{
			strcat(path, templates.dirs[i_dir].files[i_file].path);
			FILE	*file = fopen(path, "w");
			if (!file)
				exiting(file_error, "cannot create file", args);
			fwrite(templates.dirs[i_dir].files[i_file].content, 1,
					strlen(templates.dirs[i_dir].files[i_file].content), file);
			fclose(file);
			printf("│   └──Creating file: %s\n", path);
		}
	}
	i_file = -1;
	while (++i_file < templates.nb_files)
	{
		FILE	*file = fopen(templates.files[i_file].path, "w");
		if (!file)
			exiting(file_error, "cannot create file", args);
		fwrite(templates.files[i_file].content, 1, strlen(templates.files[i_file].content), file);
		fclose(file);
		printf("├──Creating file: %s\n", templates.files[i_file].path);
	}
}

/** @todo */
int	main(int ac, char **av)
{
	t_args	*args = NULL;

	args = handler_args(ac, av);
	if (!args)
		exiting(alloc_error, "cannot allocate memory for args", NULL);
	if (args->invalide)
		exiting(invalid_arg, "invalid argument", args);
	template_builder(args, "42-repo", tmp_42_repo);
	return (0);
}
