#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Right < ActiveRecord::Base
  has_many :grants
  has_many :roles, :through => :grants  
  OPERATION_MAPPINGS = {
    "new" => "CREATE",
    "create" => "CREATE",
    "edit" => "UPDATE",
    "update" => "UPDATE",
    "destroy" => "DELETE",
    "show" => "READ",
    "index" => "READ"
  }
end
