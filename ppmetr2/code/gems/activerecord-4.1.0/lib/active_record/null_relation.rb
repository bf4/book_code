#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# -*- coding: utf-8 -*-

module ActiveRecord
  module NullRelation # :nodoc:
    def exec_queries
      @records = []
    end

    def pluck(*column_names)
      []
    end

    def delete_all(_conditions = nil)
      0
    end

    def update_all(_updates, _conditions = nil, _options = {})
      0
    end

    def delete(_id_or_array)
      0
    end

    def size
      0
    end

    def empty?
      true
    end

    def any?
      false
    end

    def many?
      false
    end

    def to_sql
      ""
    end

    def count(*)
      0
    end

    def sum(*)
      0
    end

    def calculate(operation, _column_name, _options = {})
      # TODO: Remove _options argument as soon we remove support to
      # activerecord-deprecated_finders.
      if operation == :count
        0
      else
        nil
      end
    end

    def exists?(_id = false)
      false
    end
  end
end
