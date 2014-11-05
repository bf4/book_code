#!/bin/sh
#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---

if [ -z "$1" ]; then
	echo "Usage: $0 connections/<db_library>" 1>&2
	exit 1
fi

ruby -I $1 -e 'Dir.foreach(".") { |file| require file if file =~ /_test.rb$/ }'
