#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  module Translation
    include ActiveModel::Translation

    # Set the lookup ancestors for ActiveModel.
    def lookup_ancestors #:nodoc:
      klass = self
      classes = [klass]
      return classes if klass == ActiveRecord::Base

      while klass != klass.base_class
        classes << klass = klass.superclass
      end
      classes
    end

    # Set the i18n scope to overwrite ActiveModel.
    def i18n_scope #:nodoc:
      :activerecord
    end
  end
end
