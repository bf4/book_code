#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord #:nodoc:
  # = Active Record Serialization
  module Serialization
    extend ActiveSupport::Concern
    include ActiveModel::Serializers::JSON

    included do
      self.include_root_in_json = false
    end

    def serializable_hash(options = nil)
      options = options.try(:clone) || {}

      options[:except] = Array(options[:except]).map { |n| n.to_s }
      options[:except] |= Array(self.class.inheritance_column)

      super(options)
    end
  end
end

require 'active_record/serializers/xml_serializer'
