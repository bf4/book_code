#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
expect(a).to matcher

expect(a).not_to matcher
# or
expect(a).to_not matcher

expect { some_code }.to matcher
#
expect { do_something }.to change(obj, :attr)
# or
expect { do_something }.to change { obj.attr }

expect { |probe| obj.some_method(&probe) }.to yield_control
