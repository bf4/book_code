#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  module Associations
    class BelongsToPolymorphicAssociation < AssociationProxy #:nodoc:
      def replace(record)
        if record.nil?
          @target = @owner[@reflection.primary_key_name] = @owner[@reflection.options[:foreign_type]] = nil
        else
          @target = (AssociationProxy === record ? record.target : record)

          @owner[@reflection.primary_key_name] = record.id
          @owner[@reflection.options[:foreign_type]] = record.class.base_class.name.to_s

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
          return nil if association_class.nil?

          if @reflection.options[:conditions]
            association_class.find(
              @owner[@reflection.primary_key_name],
              :select     => @reflection.options[:select],
              :conditions => conditions,
              :include    => @reflection.options[:include]
            )
          else
            association_class.find(@owner[@reflection.primary_key_name], :select => @reflection.options[:select], :include => @reflection.options[:include])
          end
        end

        def foreign_key_present
          !@owner[@reflection.primary_key_name].nil?
        end

        def association_class
          @owner[@reflection.options[:foreign_type]] ? @owner[@reflection.options[:foreign_type]].constantize : nil
        end
    end
  end
end
