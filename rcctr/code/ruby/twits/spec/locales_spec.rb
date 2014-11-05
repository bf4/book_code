#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'locales'

describe Locales do

  describe Locales::Locale do
    let(:locale) { Locales::Locale.new(/\d{5}/) }

    it "parses postal codes with a regex" do
      locale.parse_postal_code('10121').should == '10121'
    end

    it "returns nil if a postal code cannot be parsed" do
      locale.parse_postal_code('abcde').should be_nil 
    end
  end

  it "Uses US Locale by default" do
    Locales.current.should == Locales::UNITED_STATES
  end

  it "can parse 5 digit zip codes" do
    Locales.current.parse_postal_code('zip is 12345').should == '12345'
  end

  it "can parse 9 digit zip codes" do
    Locales.current.parse_postal_code('zip is 12345-6789').should == '12345-6789'
  end

  it "allows the locale to be changed" do
    Locales.current = Locales::UNITED_KINGDOM
    Locales.current.should == Locales::UNITED_KINGDOM
  end
end
