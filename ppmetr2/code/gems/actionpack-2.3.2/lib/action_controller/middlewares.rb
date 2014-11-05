#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
use "Rack::Lock", :if => lambda {
  !ActionController::Base.allow_concurrency
}

use "ActionController::Failsafe"

use lambda { ActionController::Base.session_store },
    lambda { ActionController::Base.session_options }

use "ActionController::RewindableInput"
use "ActionController::ParamsParser"
use "Rack::MethodOverride"
use "Rack::Head"
