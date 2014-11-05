#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module Rails
  module Generators
    class ActiveModel
      attr_reader :name
      def initialize(name)
        @name = name
      end
      # GET index
      def self.all(klass)
        "#{klass}.all"
      end

      # GET show
      # GET edit
      # PATCH/PUT update
      # DELETE destroy
      def self.find(klass, params=nil)
        "#{klass}.find(#{params})"
      end
      # GET new
      # POST create
      def self.build(klass, params=nil)
        if params
          "#{klass}.new(#{params})"
        else
          "#{klass}.new"
        end
      end

      # POST create
      def save
        "#{name}.save"
      end
      # PATCH/PUT update
      def update(params=nil)
        "#{name}.update(#{params})"
      end
      # POST create
      # PATCH/PUT update
      def errors
        "#{name}.errors"
      end
      # DELETE destroy
      def destroy
        "#{name}.destroy"
      end
    end
  end
end