#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
describe "something" do
  it "does something" do
    p example.metadata
  end
end

describe "something", :a => "A" do
  it "does something", :b => "B" do
    puts example.metadata[:a]
    puts example.metadata[:b]
  end
end
