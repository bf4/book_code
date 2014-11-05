#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Book
  def title # ...
  end

  def subtitle # ...
  end
  
  def lend_to(user)
    puts "Lending to #{user}"
    # ...
  end


  def self.deprecate(old_method, new_method)
    define_method(old_method) do |*args, &block|
      warn "Warning: #{old_method}() is deprecated. Use #{new_method}()."
      send(new_method, *args, &block)
    end
  end
  
  deprecate :GetTitle, :title
  deprecate :LEND_TO_USER, :lend_to
  deprecate :title2, :subtitle
end

b = Book.new
b.LEND_TO_USER("Bill")

# capture warning
alias :old_warn :warn
$warnings = ""
def warn(s)
  $warnings << s
end

b.LEND_TO_USER("Bill")
require_relative '../test/assertions'
assert_equals "Warning: LEND_TO_USER() is deprecated. Use lend_to().", $warnings.to_s

# reset warnings
alias :warn :old_warn
