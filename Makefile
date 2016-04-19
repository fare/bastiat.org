export LISP=cmucl
export BA=$(shell pwd)
export FARE=${HOME}

all: ALL

.depend:
	zsh -f script.zsh depend > .depend

include .depend

.PHONY: dep depend tdepend

dep: depend

depend: .depend

tdepend:
	zsh -f script.zsh tdepend

clean::
	zsh -f script.zsh clean

alldirs:

fr/gratuite_du_credit.html: $(wildcard fr/lettre[1-9]*.scr)

ALL:	allfiles alldirs

# works best with clisp...
allscr:
	exscribe --include ${BA} --include ${FARE}/fare/www --many ${BA} ${BA}/html */*.scr
