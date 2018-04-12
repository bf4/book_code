#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
class Notifier
  attr_reader :generator, :callbacks

  def initialize(generator, callbacks)
    @generator = generator
    @callbacks = callbacks
  end

  def run
    result = generator.run
    if result
      callbacks.fetch(:on_success).call(result)
    else
      callbacks.fetch(:on_failure).call
    end
  end
end
