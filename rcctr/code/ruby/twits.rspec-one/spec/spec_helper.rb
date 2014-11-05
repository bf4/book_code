#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'twits'
require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'irb'
require 'irb/completion'

module IRB
   def IRB.parse_opts
     # Don't touch ARGV, which belongs to the app which called this module.
   end
end

#  def self.behavior(obj)
#    if @methods
#      @methods = @methods.select{|met| @methods.member? met }
#    else
#      @methods = obj.public_methods
#    end
#  end
# puts "Common Methods: #{@methods.sort.join(', ')}" if @methods

module Compare
  def self.type(obj)
    @objects ||= []
    @objects << obj
  end

  def self.report
    puts "Object Types: #{@objects.collect{|o| o.class}.join(', ')}" if @objects
  end
end


class Object
  def put_methods(regex=/.*/)
    puts self.methods.grep(regex)
  end
end

Spec::Runner.configure do |config|
  config.after(:suite) do
    Compare.report
  end
end
