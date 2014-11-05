#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
shared_context 'a new document' do            #(1)
  before do                                   #(2)
    @note = Note.open
  end

  after do                                    #(3)
    @note.exit! if @note.running?             #(4)
  end
end

shared_context 'a saved document' do
  before do
    Note.fixture 'SavedNote'                  #(5)
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
  before do
    @sentence = 'The longest island is Isabel Island.'
    @term = 'Is'

    @first_match = @sentence.index(/Is/i)
    @second_match = @sentence.index(/Is/i, @first_match + 1)
    @reverse_match = @sentence.rindex(/Is/i)
    @word_match = @sentence.index(/Is\b/i)
    @case_match = @sentence.index(/Is/)

    @note.text = @sentence
  end
end
