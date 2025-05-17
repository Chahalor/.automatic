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

init_dotfile:
	@if [ ! -f .dotfile/.zshrc ]; then \
		echo "❌ .dotfile/.zshrc is missing!"; \
		exit 1; \
	fi
	@echo "🔗 Linking ~/.zshrc → .dotfile/.zshrc"
	@rm -f ~/.zshrc
	@ln -sf "$(realpath .dotfile/.zshrc)" ~/.zshrc
	