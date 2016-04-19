How to hack bastiat.org
=======================

Installing the toolchain
------------------------

  1. Install sbcl. On Ubuntu and other debian-based distributions, use:

        sudo apt-get install sbcl

  2. Download Quicklisp:

        wget https://beta.quicklisp.org/quicklisp.lisp

  3. Install Quicklisp:

        sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)'

  4. Compile Exscribe:

        sbcl --eval '(load "~/quicklisp/setup")' --eval '(ql:quickload :exscribe/typeset)' --eval '(progn (setf uiop:*image-entry-point* (lambda () (exscribe::main uiop:*command-line-arguments*))) (uiop:dump-image "exscribe" :executable t))'

  5. Move Exscribe to a place in your `$PATH`, e.g.:

        sudo install -m 755 -o 0 -g 0  exscribe /usr/local/bin/

  6. Make sure you have a copy of my `fare-style.scr` in your `bastiat.org/` checkout.

        wget http://fare.tunes.org/files/exscribe/fare-style.scr


Building the website
--------------------

Once you've properly installed your toolchain, you can build the website with::

	make

Then point your browser to the index file and browse, like:

    chrome file://$PWD/fr/index.html

or:

    firefox file://$PWD/en/index.html


Publishing
----------

Either:

   1. Fork [the official repository on github](http://github.com/fare/bastiat.org),
      and send a pull request, or

   2. Have me add you to [the official repository on github](http://github.com/fare/bastiat.org),
      and push there, and also
	  get [an account on bespin.org](bespin.org/application.html),
	  and rsync there.
