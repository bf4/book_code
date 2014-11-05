#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "cases/helper"
require 'models/contact'

class SerializationTest < ActiveRecord::TestCase
  FORMATS = [ :xml, :json ]

  def setup
    @contact_attributes = {
      :name        => 'aaron stack',
      :age         => 25,
      :avatar      => 'binarydata',
      :created_at  => Time.utc(2006, 8, 1),
      :awesome     => false,
      :preferences => { :gem => '<strong>ruby</strong>' }
    }

    @contact = Contact.new(@contact_attributes)
  end

  def test_serialize_should_be_reversible
    for format in FORMATS
      @serialized = Contact.new.send("to_#{format}")
      contact = Contact.new.send("from_#{format}", @serialized)

      assert_equal @contact_attributes.keys.collect(&:to_s).sort, contact.attributes.keys.collect(&:to_s).sort, "For #{format}"
    end
  end

  def test_serialize_should_allow_attribute_only_filtering
    for format in FORMATS
      @serialized = Contact.new(@contact_attributes).send("to_#{format}", :only => [ :age, :name ])
      contact = Contact.new.send("from_#{format}", @serialized)
      assert_equal @contact_attributes[:name], contact.name, "For #{format}"
      assert_nil contact.avatar, "For #{format}"
    end
  end

  def test_serialize_should_allow_attribute_except_filtering
    for format in FORMATS
      @serialized = Contact.new(@contact_attributes).send("to_#{format}", :except => [ :age, :name ])
      contact = Contact.new.send("from_#{format}", @serialized)
      assert_nil contact.name, "For #{format}"
      assert_nil contact.age, "For #{format}"
      assert_equal @contact_attributes[:awesome], contact.awesome, "For #{format}"
    end
  end
end
