#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Validateable
  [:save, :save!, :update_attribute].each{|attr| define_method(attr){}}
  def method_missing(symbol, *params)
    if(symbol.to_s =~ /(.*)_before_type_cast$/) 
      send($1)
    end
  end
  def self.append_features(base)
    super
    base.send(:include, ActiveRecord::Validations)
  end
end
