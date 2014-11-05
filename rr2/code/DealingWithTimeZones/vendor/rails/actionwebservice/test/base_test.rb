#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/abstract_unit'

module BaseTest
  class API < ActionWebService::API::Base
    api_method :add, :expects => [:int, :int], :returns => [:int]
    api_method :void
  end

  class PristineAPI < ActionWebService::API::Base
    inflect_names false

    api_method :add
    api_method :under_score
  end

  class Service < ActionWebService::Base
    web_service_api API

    def add(a, b)
    end
  
    def void
    end
  end
  
  class PristineService < ActionWebService::Base
    web_service_api PristineAPI

    def add
    end

    def under_score
    end
  end
end

class TC_Base < Test::Unit::TestCase
  def test_options
    assert(BaseTest::PristineService.web_service_api.inflect_names == false)
    assert(BaseTest::Service.web_service_api.inflect_names == true)
  end
end
