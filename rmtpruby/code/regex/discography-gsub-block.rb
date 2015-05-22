#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "date"

discography = %(
1994 - Zopilote Machine
1995 - Sweden
1996 - Nothing for Juice
1997 - Full Force Galesburg
2000 - The Coroner's Gambit
2002 - All Hail West Texas
2002 - Tallahassee
2004 - We Shall All Be Healed
2005 - The Sunset Tree
2006 - Get Lonely
2008 - Heretic Pride
2009 - The Life of the World to Come
2011 - All Eternals Deck
2012 - Transcendental Youth
2015 - Beat the Champ
)

discography = discography.gsub(/^(?<year>[0-9]{4}) - (?<album>.+)$/) do |match|
  album_year = $~[:year].to_i
  years_ago = Date.today.year - album_year
  title = $~[:album]

  "#{title} (#{years_ago} years ago)"
end

puts discography

# >> Zopilote Machine (21 years ago)
# >> Sweden (20 years ago)
# >> Nothing for Juice (19 years ago)
# >> Full Force Galesburg (18 years ago)
# >> The Coroner's Gambit (15 years ago)
# >> All Hail West Texas (13 years ago)
# >> Tallahassee (13 years ago)
# >> We Shall All Be Healed (11 years ago)
# >> The Sunset Tree (10 years ago)
# >> Get Lonely (9 years ago)
# >> Heretic Pride (7 years ago)
# >> The Life of the World to Come (6 years ago)
# >> All Eternals Deck (4 years ago)
# >> Transcendental Youth (3 years ago)
# >> Beat the Champ (0 years ago)
