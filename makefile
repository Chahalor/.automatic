# Big Header

# This makefile will initialize .automatic on a new place

# **************************** #
# ******** Variables ********* #
# **************************** #

DIR_MAIN = ~/automatic
DIR_NEW = $(DIR_MAIN)/new
DIR_DOTFILE = $(DIR_MAIN)/.dotfile
DIR_ALIAS = $(DIR_MAIN)/alias

# **************************** #
# ********* Includes ********* #
# **************************** #

-include $(DIR_NEW)/makefile.mk
-include $(DIR_DOTFILE)/makefile.mk
-include $(DIR_ALIAS)/makefile.mk

# **************************** #
# ********** Rules *********** #
# **************************** #

.PHONY: all init alias new dotfile

all:
	@echo "This makefile will initialize .automatic on a new place"
	@echo "Please run 'make init' to initialize the directory"

init: alias new dotfile

alias: init_alias

new: init_new

dotfile: init_dotfile

setup:
	@if [ -f ~/login.sh ]; then \
		if ! grep -Fxq "git pull ~/.automatic;" ~/login.sh; then \
			echo "git pull ~/.automatic;" >> ~/login.sh; \
		fi \
	fi
