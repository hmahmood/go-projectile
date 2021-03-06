EMACS ?= emacs
EMACSFLAGS =
CASK = cask

OBJECTS = go-projectile.elc

elpa:
	$(CASK) install
	$(CASK) update
	touch $@

.PHONY: build
build : elpa $(OBJECTS)

.PHONY: test
test : build
	PATH=$(PATH):$(HOME)/.emacs.d/el-get/go-autocomplete/bin \
	$(CASK) exec $(EMACS) --no-site-file --no-site-lisp --batch \
		$(EMACSFLAGS) \
		-l test/run-tests

.PHONY: clean
clean :
	rm -f $(OBJECTS)
	rm -f elpa
	rm -rf .cask # Clean packages installed for development

%.elc : %.el
	$(CASK) exec $(EMACS) --no-site-file --no-site-lisp --batch \
		$(EMACSFLAGS) \
		-f batch-byte-compile $<
