#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
class Tokenizer
  def self.tokenize(string)
    string.split(/ +/)
  end
end

RSpec.describe Tokenizer do
  let(:text) do
    <<-EOS
      I am Sam.
      Sam I am.
      Do you like green eggs and ham?
    EOS
  end

  it 'tokenizes multiple lines of text' do
    tokenized = Tokenizer.tokenize(text)
    expect(tokenized).to start_with('I', 'am', 'Sam.', 'Sam', 'I', 'am')
  end
end
