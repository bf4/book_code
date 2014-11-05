#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

# class TranslatingController < ActionController::Base
# end

class TranslationControllerTest < Test::Unit::TestCase
  def setup
    @controller = ActionController::Base.new
  end
  
  def test_action_controller_base_responds_to_translate
    assert @controller.respond_to?(:translate)
  end
  
  def test_action_controller_base_responds_to_t
    assert @controller.respond_to?(:t)
  end
  
  def test_action_controller_base_responds_to_localize
    assert @controller.respond_to?(:localize)
  end
  
  def test_action_controller_base_responds_to_l
    assert @controller.respond_to?(:l)
  end
end