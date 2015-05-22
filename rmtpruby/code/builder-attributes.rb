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

xml = builder.gallery do |gallery|
  gallery.name "The National Gallery"
  gallery.location "London, UK"

  gallery.collection do |collection|
    collection.painting(
      name: "Anna and the Blind Tobit",
      artist: "Rembrandt",
      year: 1630
    )

    collection.painting(
      name: "The Stonemason's Yard",
      artist: "Canaletto",
      year: 1725
    )
  end
end

puts xml
# >> <gallery>
# >>   <name>The National Gallery</name>
# >>   <location>London, UK</location>
# >>   <collection>
# >>     <painting name="Anna and the Blind Tobit" artist="Rembrandt" year="1630"/>
# >>     <painting name="The Stonemason's Yard" artist="Canaletto" year="1725"/>
# >>   </collection>
# >> </gallery>
