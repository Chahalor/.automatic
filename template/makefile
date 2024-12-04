# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    C-makefile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nduvoid <nduvoid@42mulhouse.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/04 13:23:32 by nduvoid           #+#    #+#              #
#    Updated: 2024/12/04 13:27:33 by nduvoid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = Title

DIR_SRC =	src
DIR_BONUS =	bonus
DIR_LIBFT =	libft
DIR_OBJ =	.obj

SRC =		# ...
SRC_BONUS =	# ...

OBJ =		$(addprefix $(DIR_OBJ)/, $(SRC:.c=.o))
OBJ_BONUS =	$(addprefix $(DIR_OBJ)/, $(SRC_BONUS:.c=.o))

CC =		cc
CFLAGS =	-Wall -Wextra -Werror
DEBUGFLAGS = -g3 -fsanitize=address

LIBFT = $(DIR_LIBFT)/libft.a

all: $(NAME)

$(NAME): $(LIBFT) $(OBJ)
	@$(CC) $(CFLAGS) $(OBJ) -o $@ $(LIBFT)

$(LIBFT):
	@make -C $(DIR_LIBFT)

$(DIR_OBJ)/%.o: $(DIR_SRC)/%.c
	@mkdir -p $(DIR_OBJ)
	@$(CC) $(CFLAGS) -o $@ -c $<

bonus: $(LIBFT) $(OBJ) $(OBJ_BONUS)
	@$(CC) $(CFLAGS) $(OBJ) $(OBJ_BONUS) -o $(NAME) $(LIBFT)

debug: CFLAGS += $(DEBUGFLAGS)

clean:
	@rm -rf $(DIR_OBJ)
	@make -C $(DIR_LIBFT) clean

fclean: clean
	@rm -f $(NAME)
	@make -C $(DIR_LIBFT) fclean

re: fclean all

.PHONY: all clean fclean re debug bonus
