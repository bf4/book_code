#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'test/unit'
require 'openid/extras'

class StartsWithTestCase < Test::Unit::TestCase
    def test_starts_with
        [["anything", ""],
         ["something else", ""],
         ["", ""],
         ["foos", "foo"],
        ].each{|str,target| assert(str.starts_with?(target))}
    end

    def test_not_starts_with
        [["x", "y"],
         ["foos", "ball"],
         ["xx", "xy"],
        ].each{|str,target| assert(!(str.starts_with? target)) }
    end

    def test_ends_with
        [["anything", ""],
         ["something else", " else"],
         ["", ""],
         ["foos", "oos"],
        ].each{|str,target| assert(str.ends_with?(target))}
    end

    def test_not_ends_with
        [["x", "y"],
         ["foos", "ball"],
         ["xx", "xy"],
         ["foosball", "foosbal"],
        ].each{|str,target| assert(!(str.ends_with? target)) }
    end
end
