#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
DATA.each do |line|
  re = %r{ ^(?>
             (?:(?<title>Mrs | Mr | Ms | Dr )\s)? (.*?) \s and \s
          ) 
             (?(<title>)\g<title>\s) (.+) 
        }x
  if line =~ re
    print "VALID:   "
  else
    print "INVALID: "
  end
  puts line
end
__END__
Mr Jones and Sally
Mr Bond and Ms Moneypenny
Samson and Delilah
Dr Jekyll and himself
Ms Hinky Smith and Ms Jones
Dr Wood and Mrs Wood
Thelma and Louise
