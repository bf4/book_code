#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "test/unit"
#
#class FooTest < Test::Unit::TestCase
#  email_fixtures("/Users/chadfowler/svn/macchad/trunk/cdbaby/customermail/test/fixtures/email/")
#
#  def test_something
#    assert_not_nil(@in_reply_to)
#  end
#end
#
#
module Test
  module Unit
    class TestCase
      def self.email_fixtures(*dirnames)
        email_fixtures = {}
        dirnames.each do |dirname|      
          Dir.glob("#{dirname}/*").each do |filename|
            next if File.directory? filename
            email_fixtures["@#{File.basename(filename).gsub(/\.[a-zA-Z]+$/, "")}"] = File.read(filename)
          end
        end  
        self.instance_variable_set "@email_fixtures", email_fixtures                  
      end           
      alias :old_initialize :initialize            
      def initialize(*args)
        self.class.instance_variable_get("@email_fixtures").each do |key, value|
          self.instance_variable_set(key, value)
        end               
        old_initialize(*args)
      end
    end
  end
end