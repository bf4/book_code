#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActiveRecord
  module Associations
    class BelongsToAssociation < AssociationProxy #:nodoc:
      def create(attributes = {})
        replace(@reflection.klass.create(attributes))
      end

      def build(attributes = {})
        replace(@reflection.klass.new(attributes))
      end

      def replace(record)
        counter_cache_name = @reflection.counter_cache_column

        if record.nil?
          if counter_cache_name && @owner[counter_cache_name] && !@owner.new_record?
            @reflection.klass.decrement_counter(counter_cache_name, @owner[@reflection.primary_key_name]) if @owner[@reflection.primary_key_name]
          end

          @target = @owner[@reflection.primary_key_name] = nil
        else
          raise_on_type_mismatch(record)

          if counter_cache_name && !@owner.new_record?
            @reflection.klass.increment_counter(counter_cache_name, record.id)
            @reflection.klass.decrement_counter(counter_cache_name, @owner[@reflection.primary_key_name]) if @owner[@reflection.primary_key_name]
          end

          @target = (AssociationProxy === record ? record.target : record)
          @owner[@reflection.primary_key_name] = record.id unless record.new_record?
          @updated = true
        end

        loaded
        record
      end
      
      def updated?
        @updated
      end
      
      private
        def find_target
          @reflection.klass.find(
            @owner[@reflection.primary_key_name], 
            :conditions => conditions,
            :include    => @reflection.options[:include]
          )
        end

        def foreign_key_present
          !@owner[@reflection.primary_key_name].nil?
        end
    end
  end
end
