#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Globalize
  # Represents a view translation in the DB, which is a translation of a string
  # in the rails application itself. This includes error messages, controllers,
  # views, and flashes, but not database content.
  class ViewTranslation < Translation # :nodoc:

    def self.pick(key, language, idx)
      find(:first, :conditions => [ 
        'tr_key = ? AND language_id = ? AND pluralization_index = ?', 
        key, language.id, idx ])
    end

  end
end
