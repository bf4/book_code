#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class AuthorizationController < ApplicationController
  roles :admin
  
  def index
    @controllers = 
      ::ActionController::Routing.possible_controllers.delete_if do |controller|
      is_it_a? controller
    end
    @controllers.collect! {|c| controller_class c }
  end
  
  private
  def controller_class(controller)
    "#{controller.camelize}Controller".constantize
  end
  
  def is_it_a?(controller)
          !controller_class(controller).is_a?(Class) ||
          !controller_class(controller).ancestors.include?(ApplicationController) ||
          !controller_class(controller).included_modules.include?(RoleBasedControllerAuthorization)
  end
end
