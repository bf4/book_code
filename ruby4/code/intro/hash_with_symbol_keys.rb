#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
 inst_section = {
   :cello     => 'string',
   :clarinet  => 'woodwind',
   :drum      => 'percussion',
   :oboe      => 'woodwind',
   :trumpet   => 'brass',
   :violin    => 'string'
 }
 inst_section[:oboe]
 inst_section[:cello]
 # Note that strings aren't the same as symbols...
 inst_section['cello']
