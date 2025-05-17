# Big Header

# This is a makefile to initialize the new module from the .automatic Project

# **************************** #
# ******** Variables ********* #
# **************************** #

# ...

# **************************** #
# ********** Rules *********** #
# **************************** #

.PHONY: alias_new init_new

init_new: alias_new
	@echo "Initializing the \"new\" module"

alias_new:
	@echo "alias new='$(realpath new/new.sh)'" >> ~/.zshrc
	@echo "alias new='$(realpath new/new.sh)'" >> ~/.bashrc
