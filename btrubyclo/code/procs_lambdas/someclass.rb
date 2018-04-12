#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
class SomeClass

  def method_that_calls_proc_or_lambda(procy)
    puts "calling #{proc_or_lambda(procy)} now!"
    procy.call
    puts "#{proc_or_lambda(procy)} gets called!"
  end

  def proc_or_lambda(proc_like_thing)
    proc_like_thing.lambda? ? "Lambda" : "Proc"
  end

end
