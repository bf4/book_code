#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "cases/helper"
require 'models/topic'
require 'models/reply'

class ActiveRecordI18nTests < Test::Unit::TestCase

  def setup
    I18n.backend = I18n::Backend::Simple.new
  end
  
  def test_translated_model_attributes
    I18n.backend.store_translations 'en', :activerecord => {:attributes => {:topic => {:title => 'topic title attribute'} } }
    assert_equal 'topic title attribute', Topic.human_attribute_name('title')
  end

  def test_translated_model_attributes_with_sti
    I18n.backend.store_translations 'en', :activerecord => {:attributes => {:reply => {:title => 'reply title attribute'} } }
    assert_equal 'reply title attribute', Reply.human_attribute_name('title')
  end

  def test_translated_model_attributes_with_sti_fallback
    I18n.backend.store_translations 'en', :activerecord => {:attributes => {:topic => {:title => 'topic title attribute'} } }
    assert_equal 'topic title attribute', Reply.human_attribute_name('title')
  end

  def test_translated_model_names
    I18n.backend.store_translations 'en', :activerecord => {:models => {:topic => 'topic model'} }
    assert_equal 'topic model', Topic.human_name
  end

  def test_translated_model_names_with_sti
    I18n.backend.store_translations 'en', :activerecord => {:models => {:reply => 'reply model'} }
    assert_equal 'reply model', Reply.human_name
  end

  def test_translated_model_names_with_sti_fallback
    I18n.backend.store_translations 'en', :activerecord => {:models => {:topic => 'topic model'} }
    assert_equal 'topic model', Reply.human_name
  end
end

