#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class Dict
  def initialize
    @hash = Hash.new {|h, k| h[k] = Array.new}
  end

  def push(fname, words)
    words.each {|w| @hash[w] << fname}
  end

  def query(word, &blk)
    @hash[word].each(&blk)
  end
end
dict = Dict.new
dict.push('lib/drip.rb', ['def', 'Drip'])
dict.push('lib/foo.rb', ['def'])
dict.push('lib/bar.rb', ['def', 'bar', 'Drip'])
dict.query('def') {|x| puts x} 
# => ["lib/drip.rb", "lib/foo.rb", "lib/bar.rb"] 
