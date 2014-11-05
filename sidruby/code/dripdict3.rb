#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'rbtree'

class Dict3
  def initialize
    @tree = RBTree.new
  end

  def push(fname, words)
    words.each {|w| @tree[[w, fname]] = true}
  end

  def query(word) # (1)
    @tree.bound([word, ''], [word + "\0", '']) {|k, v| yield(k[1])}
  end
end
dict = Dict3.new
dict.push('lib/drip.rb', ['def', 'Drip'])
dict.push('lib/foo.rb', ['def'])
dict.push('lib/bar.rb', ['def', 'bar', 'Drip'])
dict.query('def') {|x| puts x} 
# => 
# "lib/bar.rb"
# "lib/drip.rb"
# "lib/foo.rb"
