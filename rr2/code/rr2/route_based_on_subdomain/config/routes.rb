#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class LegacyParameterMatcher
  def initialize(regular_expression)
    @regular_expression = regular_expression
  end

  def matches?(request)
    request.params.keys.grep(@regular_expression).any?
  end
end
RouteBasedOnSubdomain::Application.routes.draw do
  root :to => "admin#index", :constraints => {:subdomain => "admin"}
  root :to => "home#index"
end
RouteBasedOnSubdomain::Application.routes.draw do
  root :to => "phone#index",
       :constraints => lambda{ |req|
                         req.params.keys.grep(/iphone/i).any?
                       }
  root :to => "home#index"
end
RouteBasedOnSubdomain::Application.routes.draw do
  root :to => "phone#index",
       :constraints => LegacyParameterMatcher.new(/iphone/i)
end
