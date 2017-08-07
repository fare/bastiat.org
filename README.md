How to hack bastiat.org
=======================

This is the source code for the [bastiat.org](http://bastiat.org/)
website dedicated to the life and works of Frédéric Bastiat.


Installing the toolchain
------------------------

  1. Install [sbcl](http://sbcl.org/). On Ubuntu and other debian-based distributions, use:

        sudo apt-get install sbcl

  2. Download [Quicklisp](https://www.quicklisp.org/beta/):

        wget https://beta.quicklisp.org/quicklisp.lisp

  3. Install Quicklisp:

        sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)'

  4. Download and compile [Exscribe](http://cliki.net/Exscribe):

        mkdir -p ~/common-lisp/
        cd ~/common-lisp/
        git clone https://github.com/fare/fare-scripts.git
        git clone https://gitlab.common-lisp.net/frideau/exscribe.git
        sbcl --eval '(load "~/quicklisp/setup")' --eval '(ql:quickload :exscribe/executable)'

  6. Make sure that your system can find the `exscribe` program:

        # One option is to create a symlink at a well-known location:
        sudo ln -sf ~/common-lisp/exscribe/exscribe /usr/local/bin/

        # Alternatively, just extend your `$PATH` variable:
        PATH=$PATH:~/common-lisp/exscribe

  7. Install [Zsh](http://www.zsh.org/). On Ubuntu and other debian-based distributions, use:

        sudo apt-get install zsh


Building the website
--------------------

Once you've properly installed your toolchain, you can build the website with:

	make

Then point your browser to the index file and browse, like:

    chrome file://$PWD/fr/index.html

or:

    firefox file://$PWD/en/index.html


Adding a new file
-----------------

If you add a new file, you need to tell the build system about it with:

	make dep

You may also have to edit the [.gitignore](.gitignore) to hush git
warnings about the `.html` file created when you built the website.


Publishing Changes
------------------

Either:

   1. Fork [the official repository on github](http://github.com/fare/bastiat.org),
      and send a pull request, or

   2. Have me add you to
      [the official repository on github](http://github.com/fare/bastiat.org),
      and to the the bastiat account on bespin
	  (maybe also get [an account on bespin.org](bespin.org/application.html)).
	  Then you can `make bespin` to rebuild the website.

Please consult a `git` tutorial for details.


What to do?
-----------

See the [TODO.md](TODO.md) file.
Take an item, break it down until you reach an actionable items, act on it.
Or add new items.
