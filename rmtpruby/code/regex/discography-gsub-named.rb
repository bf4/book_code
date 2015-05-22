#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
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

puts discography.gsub(/^(?<year>[0-9]{4}) - (?<album>.+)$/, '\k<album> \k<year>')

# >> Zopilote Machine 1994
# >> Sweden 1995
# >> Nothing for Juice 1996
# >> Full Force Galesburg 1997
# >> The Coroner's Gambit 2000
# >> All Hail West Texas 2002
# >> Tallahassee 2002
# >> We Shall All Be Healed 2004
# >> The Sunset Tree 2005
# >> Get Lonely 2006
# >> Heretic Pride 2008
# >> The Life of the World to Come 2009
# >> All Eternals Deck 2011
# >> Transcendental Youth 2012
# >> Beat the Champ 2015
