#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
class Router

  def initialize(&block)
    instance_eval &block
  end

  def match(route)
    puts route
  end

end

routes = Router.new do
  match '/about' => 'home#about'
end
