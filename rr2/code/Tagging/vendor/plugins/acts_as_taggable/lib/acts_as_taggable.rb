#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActiveRecord
  module Acts #:nodoc:
    module Taggable #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)  
      end
      
      module ClassMethods
        def acts_as_taggable(options = {})
          write_inheritable_attribute(:acts_as_taggable_options, {
            :taggable_type => ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s,
            :from => options[:from]
          })
          
          class_inheritable_reader :acts_as_taggable_options

          has_many :taggings, :as => :taggable, :dependent => true
          has_many :tags, :through => :taggings

          include ActiveRecord::Acts::Taggable::InstanceMethods
          extend ActiveRecord::Acts::Taggable::SingletonMethods          
        end
      end
      
      module SingletonMethods
        def find_tagged_with(list)
          find_by_sql(
            "SELECT #{table_name}.* FROM #{table_name}, tags, taggings " +
            "WHERE #{table_name}.#{primary_key} = taggings.taggable_id " +
            "AND taggings.taggable_type = '#{acts_as_taggable_options[:taggable_type]}' " +
            "AND taggings.tag_id = tags.id AND tags.name IN (#{list.collect { |name| "'#{name}'" }.join(", ")})"
          )
        end
      end
      
      module InstanceMethods
        def tag_with(list)
          Tag.transaction do
            taggings.destroy_all

            Tag.parse(list).each do |name|
              if acts_as_taggable_options[:from]
                send(acts_as_taggable_options[:from]).tags.find_or_create_by_name(name).on(self)
              else
                Tag.find_or_create_by_name(name).on(self)
              end
            end
          end
        end

        def tag_list
          tags.collect { |tag| righttag.name.include?(" ") ? "'#{tag.name}'" : tag.name }.join(" ")
        end
      end
    end
  end
end