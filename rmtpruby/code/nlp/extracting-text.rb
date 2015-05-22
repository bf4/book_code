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

urls = File.readlines("urls.txt").map(&:chomp)

Article = Struct.new(:title, :text, :terms)

articles = urls.map do |url|
  $stderr.puts "Processing #{url}..."

  html = open(url).read
  document = Readability::Document.new(html)

  title = document.title.sub(" - Wikipedia, the free encyclopedia", "")
  text = Nokogiri::HTML(document.content).text.strip

  Article.new(title, text)
end

