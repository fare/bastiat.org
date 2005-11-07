export LISP=cmucl

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

alldirs:

fr/gratuite_du_credit.html: $(wildcard fr/lettre[1-9]*.scr)

ALL:	allfiles alldirs
