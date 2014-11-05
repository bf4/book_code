#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
fixture.days  = 1
fixture.hours = 47
fixture.mins  = 59
fixture.secs  = 59 #(1)

passed = (fixture.days == 2)
passed &&= (fixture.hours == 23)
passed &&= (fixture.mins == 59)
passed &&= (fixture.secs == 59)
