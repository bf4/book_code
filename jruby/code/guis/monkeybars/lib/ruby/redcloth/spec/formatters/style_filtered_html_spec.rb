#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require File.dirname(__FILE__) + '/../spec_helper'

describe "style_filtered_html" do
  examples_from_yaml do |doc|
    RedCloth.new(doc['in'], [:filter_styles]).to_html
  end
end