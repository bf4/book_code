#!/usr/bin/env ruby
#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---

#--
# Portions copyright 2004 by Jim Weirich (jim@weirichhouse.org).
# Portions copyright 2005 by Sam Ruby (rubys@intertwingly.net).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#++

require 'test/unit'
require 'builder/xchar'

class TestNameCollisions < Test::Unit::TestCase
  module Collide
    def xchr
    end
  end

  def test_no_collision
    assert_nothing_raised do
      Builder.check_for_name_collision(Collide, :not_defined)
    end
  end

  def test_collision
    assert_raise RuntimeError do
      Builder.check_for_name_collision(Collide, "xchr")
    end
  end

  def test_collision_with_symbol
    assert_raise RuntimeError do
      Builder.check_for_name_collision(Collide, :xchr)
    end
  end
end
