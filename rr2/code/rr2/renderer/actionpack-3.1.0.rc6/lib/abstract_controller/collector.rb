#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "action_dispatch/http/mime_type"

module AbstractController
  module Collector
    def self.generate_method_for_mime(mime)
      sym = mime.is_a?(Symbol) ? mime : mime.to_sym
      const = sym.to_s.upcase
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{sym}(*args, &block)                # def html(*args, &block)
          custom(Mime::#{const}, *args, &block)  #   custom(Mime::HTML, *args, &block)
        end                                      # end
      RUBY
    end

    Mime::SET.each do |mime|
      generate_method_for_mime(mime)
    end

  protected

    def method_missing(symbol, &block)
      mime_constant = Mime.const_get(symbol.to_s.upcase)

      if Mime::SET.include?(mime_constant)
        AbstractController::Collector.generate_method_for_mime(mime_constant)
        send(symbol, &block)
      else
        super
      end
    end
  end
end