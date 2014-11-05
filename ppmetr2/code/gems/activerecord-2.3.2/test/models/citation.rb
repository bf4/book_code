#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Citation < ActiveRecord::Base
  belongs_to :reference_of, :class_name => "Book", :foreign_key => :book2_id

  belongs_to :book1, :class_name => "Book", :foreign_key => :book1_id
  belongs_to :book2, :class_name => "Book", :foreign_key => :book2_id
end
