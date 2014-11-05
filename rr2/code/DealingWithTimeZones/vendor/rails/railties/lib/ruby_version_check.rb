#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
min_release  = "1.8.2 (2004-12-25)"
ruby_release = "#{RUBY_VERSION} (#{RUBY_RELEASE_DATE})"
if ruby_release =~ /1\.8\.3/
  abort <<-end_message

    Rails does not work with Ruby version 1.8.3.
    Please upgrade to version 1.8.4 or downgrade to 1.8.2.

  end_message
elsif ruby_release < min_release
  abort <<-end_message

    Rails requires Ruby version #{min_release} or later.
    You're running #{ruby_release}; please upgrade to continue.

  end_message
end
