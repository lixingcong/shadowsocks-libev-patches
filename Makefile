SS_DIR     ?= $(PWD)/shadowsocks-libev
PATCH_DIR  := patches
PATCHES    := $(sort $(wildcard $(PATCH_DIR)/*.patch))
PATCHED    := $(sort $(patsubst $(PATCH_DIR)/%.patch, $(PATCH_DIR)/%.patched, $(PATCHES)))

all:$(PATCHED)
	@echo "Patches have been applied, please complie it manually"
	@echo "SS_DIR=$(SS_DIR)"

# disable parallel build for patching files
# for preventing from producing out of order chunks
.NOTPARALLEL: %.patched
%.patched:%.patch
	@echo "Applying $^"
	@patch -p 1 -d $(SS_DIR) < $^ && touch $@
	@echo

.PHONY: reset_submodule
reset_submodule:
	git submodule foreach --recursive git reset --hard
	git submodule foreach --recursive git clean -f

.PHONY: remove_patched
remove_patched:
	find . \( -name \*.orig -o -name \*.rej \) -delete
	rm -rf $(PATCHED)

.PHONY: clean
clean:
	$(MAKE) remove_patched
	$(MAKE) reset_submodule
