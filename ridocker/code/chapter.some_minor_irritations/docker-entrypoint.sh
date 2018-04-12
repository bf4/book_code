#!/bin/sh
#---
# Excerpted from "Docker for Rails Developers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/ridocker for more book information.
#---
set -e

if [ -f tmp/pids/server.pid ]; then 
  rm tmp/pids/server.pid            
fi

exec "$@"                           
