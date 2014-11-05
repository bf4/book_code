#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
ActiveRecord::Base.table_name_prefix = "wp_"
#
#
ActiveRecord::Base.primary_key_prefix_type = :table_name_with_underscore
#
