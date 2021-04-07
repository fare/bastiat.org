# This file contains the part of the overall makefile;
# this file contains the part that is specific to
# deployment of the content to the main instance
# at `http://bastiat.org/'.

.PHONY: bespin
bespin:
	zsh ./script.zsh update_bespin
