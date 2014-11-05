#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

# http://www.ralree.info/2006/9/13/extending-redcloth
module RedClothSmileyExtension
  def refs_smiley(text)
    text.gsub!(/(\s)~(:P|:D|:O|:o|:S|:\||;\)|:'\(|:\)|:\()/) do |m|
      bef,ma = $~[1..2]
      filename = "/images/emoticons/"+(ma.unpack("c*").join('_'))+".png"
      "#{bef}<img src='#{filename}' title='#{ma}' class='smiley' />"
    end
  end
end

RedCloth.send(:include, RedClothSmileyExtension)

describe RedClothSmileyExtension do
  
  it "should include the extension" do
    input  = %Q{You're so silly! ~:P}

    html  = %Q{<p>You&#8217;re so silly! <img src='/images/emoticons/58_80.png' title=':P' class='smiley' /></p>}

    RedCloth.new(input).to_html(:textile, :refs_smiley).should == html
  end
  
end