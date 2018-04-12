#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
RSpec::Matchers.define :violate_check_constraint do |constraint_name| # (1)
  supports_block_expectations                                         # (2)
  match do |code_to_test|                                             # (3)
    begin
      code_to_test.()                                                 # (4)
      false                                                           # (5)
    rescue ActiveRecord::StatementInvalid => ex                       # (6)
      ex.message =~ /#{constraint_name}/                              # (7)
    end
  end
end

