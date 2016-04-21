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

  4. Compile [Exscribe](http://cliki.net/Exscribe):

        sbcl --eval '(load "~/quicklisp/setup")' --eval '(ql:quickload :exscribe/typeset)' --eval '(progn (setf uiop:*image-entry-point* (lambda () (exscribe::main uiop:*command-line-arguments*))) (uiop:dump-image "exscribe" :executable t))'

  5. Move Exscribe to a place in your `$PATH`, e.g.:

        sudo install -m 755 -o 0 -g 0 exscribe /usr/local/bin/


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

   2. Have me add you to [the official repository on github](http://github.com/fare/bastiat.org),
      and push there, and also
	  get [an account on bespin.org](bespin.org/application.html),
	  and rsync there.

Please consult a `git` tutorial for details.
