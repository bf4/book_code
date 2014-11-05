#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionController
  module Macros
    module InPlaceEditing #:nodoc:
      def self.append_features(base) #:nodoc:
        super
        base.extend(ClassMethods)
      end

      # Example:
      #
      #   # Controller
      #   class BlogController < ApplicationController
      #     in_place_edit_for :post, :title
      #   end
      #
      #   # View
      #   <%= in_place_editor_field :post, 'title' %>
      #
      # For help on defining an in place editor in the browser,
      # see ActionView::Helpers::JavaScriptHelper.
      module ClassMethods
        def in_place_edit_for(object, attribute, options = {})
          define_method("set_#{object}_#{attribute}") do
            @item = object.to_s.camelize.constantize.find(params[:id])
            @item.update_attribute(attribute, params[:value])
            render :text => @item.send(attribute)
          end
        end
      end
    end
  end
end
