EXT_NAME=Anti-TIG
SRC_DIR=$(EXT_NAME)
BUILD_DIR=build
PROFILE_NAME=antiTIG-dev
PROFILE_PATH=$(PROFILE_NAME)

.PHONY: all run clean

all: build run

build:
	web-ext build --source-dir=$(SRC_DIR) --artifacts-dir=$(BUILD_DIR)

create-profile:
	@echo "Creating Firefox profile: $(PROFILE_NAME)"
	firefox -CreateProfile "$(PROFILE_NAME) $(PROFILE_PATH)" || true

FIREFOX_PATH=/snap/bin/firefox
FIREFOX_PROFILE_DIR=$(HOME)/snap/firefox/common/.mozilla/firefox
PROFILE_NAME=antiTIG-dev
PROFILE_PATH=$(FIREFOX_PROFILE_DIR)/$(PROFILE_NAME)

run:
	web-ext run --source-dir=$(SRC_DIR) \
		--firefox=$(FIREFOX_PATH) \
		--firefox-profile=$(PROFILE_PATH)


clean:
	rm -rf $(BUILD_DIR)
