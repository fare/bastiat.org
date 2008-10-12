export LISP=cmucl
export BA=$(shell pwd)

ifeq (.depend, $(wildcard .depend))
all: ALL

include .depend
else
all: depend
endif

.PHONY: dep depend tdepend

dep: depend

depend:
	zsh -f script.zsh depend > .depend

tdepend:
	zsh -f script.zsh tdepend

clean::
	zsh -f script.zsh clean

alldirs:

fr/gratuite_du_credit.html: $(wildcard fr/lettre[1-9]*.scr)

ALL:	allfiles alldirs

# works best with clisp...
allscr:
	exscribe --include ${BA} --include ~fare/fare/www --many ${BA} ${BA}/html */*.scr
