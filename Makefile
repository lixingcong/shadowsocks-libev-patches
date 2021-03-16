SS_DIR     := shadowsocks-libev
PATCH_DIR  := patches
PATCHES    := $(wildcard $(PATCH_DIR)/*.patch)
PATCHED    := $(patsubst $(PATCH_DIR)/%.patch, $(PATCH_DIR)/%.patched, $(PATCHES))

all:$(PATCHED)
	@echo "Patches have been applied, please complie $(SS_DIR) manually"

# disable parallel build for patching files
# for preventing from producing out of order chunks
.NOTPARALLEL: %.patched
%.patched:%.patch
	@patch -p 1 -d $(SS_DIR) < $^ && touch $@

.PHONY: reset_submodule
reset_submodule:
	git submodule foreach --recursive git reset --hard

.PHONY: remove_patched
remove_patched:
	find . \( -name \*.orig -o -name \*.rej \) -delete
	rm -rf $(PATCHED)

.PHONY: clean
clean:
	$(MAKE) remove_patched
	$(MAKE) reset_submodule
