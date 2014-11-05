#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Page < ActiveRecord::Base
  cattr_accessor :feeling_good
  @@feeling_good = true
  
  acts_as_versioned :if => :feeling_good?
    
  def feeling_good?
    @@feeling_good == true
  end
end

class LockedPage < ActiveRecord::Base
  acts_as_versioned \
    :inheritance_column => :version_type, 
    :foreign_key        => :page_id, 
    :table_name         => :locked_pages_revisions, 
    :class_name         => 'LockedPageRevision',
    :version_column     => :lock_version,
    :limit              => 2,
    :if_changed         => :title
end

class SpecialLockedPage < LockedPage
end