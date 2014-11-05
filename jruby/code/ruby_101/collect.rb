#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
primes     = [1, 3, 5, 'seven']
composites = [2, 4, 6, 9, 10]
misc       = [0]

# Oops.  We should store 7 as a prime.  Let's fix that:
primes[3] = 7

numbers = {:primes => primes, :composites => misc}

# Oops.  We gave the wrong list for composites.  Let's fix that:
numbers[:composites] = composites
