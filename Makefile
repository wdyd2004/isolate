# Makefile for Isolate
# (c) 2015 Martin Mares <mj@ucw.cz>

all: isolate isolate.1 isolate.1.html

CC=gcc
CFLAGS=-std=gnu99 -Wall -Wextra -Wno-parentheses -Wno-unused-result -Wno-missing-field-initializers

isolate: isolate.c config.h
	$(CC) $(CFLAGS) -o $@ $^

isolate.1: isolate.1.txt
	a2x -f manpage -D . $<

# The dependency on isolate.1 is there to serialize both calls of asciidoc,
# which does not name temporary files safely.
isolate.1.html: isolate.1.txt isolate.1
	a2x -f xhtml -D . $<

clean:
	rm -f isolate isolate.1 isolate.1.html
	rm -f docbook-xsl.css

.PHONY: all clean
