#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "builder"

builder = Builder::XmlMarkup.new(:indent => 2)

xml = builder.car do |car|
  car.make "Ford"
  car.model "Model T"
  car.engine do |engine|
    engine.size "2.9 L"
    engine.power "20 hp"
  end
end

puts xml
# >> <car>
# >>   <make>Ford</make>
# >>   <model>Model T</model>
# >>   <engine>
# >>     <size>2.9 L</size>
# >>     <power>20 hp</power>
# >>   </engine>
# >> </car>
