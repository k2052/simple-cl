LISP ?= sbcl

all: build

build:
	$(LISP) --non-interactive --load build.lisp

test:
	$(LISP) --non-interactive --load test.lisp

clean:
	rm -f build/hello-world

.PHONY: all build test clean
