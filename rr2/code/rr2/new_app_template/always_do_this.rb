#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
run "rm public/index.html"
generate :model, "Page title:string body:text"
generate :controller, "Pages index"
rake "db:migrate"
route 'root :to => "pages#index"'
gem "ruby-debug"
initializer "enumerable_ar.rb", <<-INIT
module ActiveRecord
  def Base.each(&block)
    all.each &block
  end
  Base.extend Enumerable
end
INIT

capify!
git :init
git :add => "."
git :commit => "-m 'Generated initial application'"


