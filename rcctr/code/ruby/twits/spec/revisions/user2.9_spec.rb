#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'revisions/user2.9'

describe "Twitter User" do
  it "uses the current locale to parse zip codes" do
    Locales.current = Locales::UNITED_KINGDOM
    user = User.new
    user.address_text = '51-55 Gresham Street, 6th Floor London, England EC2V 7HQ'
    user.zip_code.should == 'EC2V 7HQ' 
  end
 
  it "uses the current locale to parse zip codes" do
    Locales.should_receive(:current).and_return(Locales::UNITED_KINGDOM);
    user = User.new
    user.address_text = '51-55 Gresham Street, 6th Floor London, England EC2V 7HQ'
    user.zip_code.should == 'EC2V 7HQ' 
  end
end
