#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Float #:nodoc:
      module Time
        # Deprication helper methods not available as core_ext is loaded first.
        def years
          ::ActiveSupport::Deprecation.warn(self.class.deprecated_method_warning(:years, "Fractional years are not respected. Convert value to integer before calling #years."), caller)
          years_without_deprecation
        end
        def months
          ::ActiveSupport::Deprecation.warn(self.class.deprecated_method_warning(:months, "Fractional months are not respected. Convert value to integer before calling #months."), caller)
          months_without_deprecation
        end

        def months_without_deprecation
          ActiveSupport::Duration.new(self * 30.days, [[:months, self]])
        end
        alias :month :months
      
        def years_without_deprecation
          ActiveSupport::Duration.new(self * 365.25.days, [[:years, self]])
        end
        alias :year :years
      end
    end
  end
end