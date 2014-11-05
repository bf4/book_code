#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'rubygems'
require 'hpricot'
require 'open-uri'

module RandomHelper
  def random_paragraph
    doc = Hpricot open('http://www.lipsum.com/feed/html?amount=1')
    (doc/"div#lipsum p").inner_html.strip #(1)
  end
end

shared_context 'a new document' do
  before do
    @note = Note.open
  end

  after do
    @note.exit! if @note.running?
  end
end

shared_context 'a saved document' do
  before do
    Note.fixture 'SavedNote'
  end
end

shared_context 'a reopened document' do
  before do
    @note = Note.open 'SavedNote'
  end

  after do
    @note.exit! if @note.running?
  end
end

shared_context 'a searchable document' do
  include RandomHelper #(2)

  before do
    @paragraph = random_paragraph #(3)

    words = @paragraph.split /[^A-Za-z]+/
    last_cap = words.select {|w| w =~ /^[A-Z]/}.last
    @term = last_cap[0..1] #(4)

    @first_match = @paragraph.index(/#{@term}/i)
    @second_match = @first_match ?
      @paragraph.index(/#{@term}/i, @first_match + 1) :
      nil
    @reverse_match = @paragraph.rindex(/#{@term}/i)
    @word_match = @paragraph.index(/#{@term}\b/i)
    @case_match = @paragraph.index(/#{@term}/)

    @note.text = @paragraph
  end
end
