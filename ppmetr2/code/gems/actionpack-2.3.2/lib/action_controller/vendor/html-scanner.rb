#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
$LOAD_PATH << "#{File.dirname(__FILE__)}/html-scanner"

module HTML
  autoload :CDATA, 'html/node'
  autoload :Document, 'html/document'
  autoload :FullSanitizer, 'html/sanitizer'
  autoload :LinkSanitizer, 'html/sanitizer'
  autoload :Node, 'html/node'
  autoload :Sanitizer, 'html/sanitizer'
  autoload :Selector, 'html/selector'
  autoload :Tag, 'html/node'
  autoload :Text, 'html/node'
  autoload :Tokenizer, 'html/tokenizer'
  autoload :Version, 'html/version'
  autoload :WhiteListSanitizer, 'html/sanitizer'
end
