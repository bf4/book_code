#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "open-uri"
require "readability"
require "phrasie"
require "json"
require "json/add/core"

urls = File.readlines("urls.txt").map(&:chomp)

Article = Struct.new(:title, :text, :terms)

def normalize_term(term)
  term.downcase.gsub("-", " ")
end

ignored_terms = ["^", "pp", "citation", "ISBN", "Retrieved", "[edit"]

articles = urls.map do |url|
  $stderr.puts "Processing #{url}..."

  html = open(url).read
  document = Readability::Document.new(html)

  title = document.title.sub(" - Wikipedia, the free encyclopedia", "")
  text = Nokogiri::HTML(document.content).text.strip

  terms = Phrasie::Extractor.new.phrases(text)
  terms = terms.reject { |term| ignored_terms.include?(term.first) }
  terms.each do |term|
    term.unshift normalize_term(term.first)
  end

  Article.new(title, text, terms)
end

articles.each do |article|
  puts article.title
  puts "Keywords: #{article.terms.take(5).map(&:first).join(", ")}\n\n"
end

File.open("articles.json", "w") do |json|
  json.write(JSON.generate(articles))
end

