#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  class DynamicScopeMatch
    def self.match(method)
      ds_match = self.new(method)
      ds_match.scope ? ds_match : nil
    end

    def initialize(method)
      @scope = true
      case method.to_s
      when /^scoped_by_([_a-zA-Z]\w*)$/
        names = $1
      else
        @scope = nil
      end
      @attribute_names = names && names.split('_and_')
    end

    attr_reader :scope, :attribute_names

    def scope?
      !@scope.nil?
    end
  end
end
