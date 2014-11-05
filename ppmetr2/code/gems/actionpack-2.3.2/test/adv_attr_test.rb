#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.dirname(__FILE__) + '/abstract_unit'
require 'action_mailer/adv_attr_accessor'

class AdvAttrTest < Test::Unit::TestCase
  class Person
    include ActionMailer::AdvAttrAccessor
    adv_attr_accessor :name
  end

  def test_adv_attr
    bob = Person.new
    assert_nil bob.name
    bob.name 'Bob'
    assert_equal 'Bob', bob.name

    assert_raise(ArgumentError) {bob.name 'x', 'y'}
  end


end