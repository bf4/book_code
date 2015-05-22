#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "json"
require "json/add/core"

require "text"

def normalize_term(term)
  term.downcase.gsub("-", " ")
end

Article = Struct.new(:title, :text, :terms)
articles = JSON.parse(File.read("articles.json"), create_additions: true)

query = normalize_term(ARGV[0])

matches =
  articles
    .select { |article|
      article.terms.find { |term, _|
        Text::Levenshtein.distance(term, query) <= 2
      }
    }

if matches.length > 0
  matches.each { |article| puts article.title }
else
  puts "No matches"
end
