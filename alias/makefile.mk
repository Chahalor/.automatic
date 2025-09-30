# Big Header

# This is a makefile to initialize the alias module from the .automatic Project

# **************************** #
# ******** Variables ********* #
# **************************** #

ALIASES := $(shell find alias -type f -name "*.sh" | while read f; do \
	name=$$(basename $$f .sh); \
	path=$$(realpath $$f); \
	echo "$$name=$$path"; \
done)

# **************************** #
# ********** Rules *********** #
# **************************** #

.PHONY: init_alias

init_alias:
	@echo "Updating aliases in ~/.zshrc..."
	@grep -qx "# Alias from .automatic" ~/.zshrc || echo "# Alias from .automatic" >> ~/.zshrc
	@$(foreach pair,$(ALIASES),\
		name=$(word 1,$(subst =, ,$(pair))); \
		path=$(word 2,$(subst =, ,$(pair))); \
		alias_line="alias $$name='$$path'"; \
		grep -qx "$$alias_line" ~/.zshrc || echo "$$alias_line" >> ~/.zshrc;)
