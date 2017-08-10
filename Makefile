all: allfiles
.PHONY: all

.DELETE_ON_ERROR:

dependencies_file=.depend

$(dependencies_file):
	./build.sh depend > $(dependencies_file)

# The following file defines the `allfiles' target.
ifeq ($(filter dep $(dependencies_file) clean,$(MAKECMDGOALS)),)
  include $(dependencies_file)
endif

fr/gratuite_du_credit.html: $(wildcard fr/lettre[1-9]*.scr)

.PHONY: dep
dep:
	@rm -f $(dependencies_file); \
	$(MAKE) $(dependencies_file)

.PHONY: clean
clean:
	./build.sh clean

BA := $(shell pwd)

# works best with clisp...
.PHONY: allscr
allscr:
	exscribe --include $(BA) --include $(HOME)/fare/www --many $(BA) $(BA)/html */*.scr

.PHONY: bespin
bespin:
	./script.zsh update_bespin
