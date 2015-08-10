#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'spec_helper.rb'

describe "Spec counting task" do

  let(:jasmine_dev) { JasmineDev.new }

  before do
    @output = capture_output { jasmine_dev.count_specs }
  end

  it "should tell the developer that the specs are being counted" do
    @output.should match(/Counting specs/)
  end

  it "should report the number of specs that will run in node" do
    @output.should match(/\d+ \e\[0mspecs for Node.js/)
  end

  it "should report the number of specs that will run in the browser" do
    @output.should match(/\d+ \e\[0mspecs for Browser/)
  end

  it "should remind the developer to check the count" do
    @output.should match(/Please verify/)
  end
end