# Big Header

# This is a makefile to initialize the .dotfile module from the .automatic Project

# **************************** #
# ******** Variables ********* #
# **************************** #

# ...

# **************************** #
# ********** Rules *********** #
# **************************** #

.PHONY: init_dotfile

_DOT_FILES := .zshrc .vimrc
_DOT_FILES := $(addprefix .dotfile/,$(_DOT_FILES))

init_dotfile:


# 	@for file in $(_DOT_FILES); do \
# 		if [ ! -f "$$file" ]; then \
# 			echo "❌ $$file is missing!"; \
# 			exit 1; \
# 		else \
# 			ln -sf "$$(realpath $$file)" ~/"$$(basename $$file)" && \
# 			echo "🔗 Linking $$file → ~/$$(basename $$file)" || \
# 			echo "❌ failed to link $$file"; \
# 		fi; \
# 	done
