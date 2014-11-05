#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionWebService # :nodoc:
  class ActionWebServiceError < StandardError # :nodoc:
  end

  # An Action Web Service object implements a specified API.
  #
  # Used by controllers operating in _Delegated_ dispatching mode.
  #
  # ==== Example
  # 
  #   class PersonService < ActionWebService::Base
  #     web_service_api PersonAPI
  #
  #     def find_person(criteria)
  #       Person.find_all [...]
  #     end
  #
  #     def delete_person(id)
  #       Person.find_by_id(id).destroy
  #     end
  #   end
  #
  #   class PersonAPI < ActionWebService::API::Base
  #     api_method :find_person,   :expects => [SearchCriteria], :returns => [[Person]]
  #     api_method :delete_person, :expects => [:int]
  #   end
  #
  #   class SearchCriteria < ActionWebService::Struct
  #     member :firstname, :string
  #     member :lastname,  :string
  #     member :email,     :string
  #   end
  class Base
    # Action WebService subclasses should be reloaded by the dispatcher in Rails
    # when Dependencies.mechanism = :load.
    include Reloadable::Subclasses

    # Whether to report exceptions back to the caller in the protocol's exception
    # format
    class_inheritable_option :web_service_exception_reporting, true
  end
end
